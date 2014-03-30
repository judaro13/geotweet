# encoding: UTF-8
require 'csv'

module Util
  class ImportCsv
    attr_writer     :file, :update_existing, :send_invitation, :org_unit
    attr_accessor   :parsing_errors, :col_separator, :users, :admin_user, :csv_content, :encoding

    attr_reader     :record_rules, :headers, :num_rows, :import_job
    
    def initialize(file: nil, update_existing: false, admin_user: nil, account: nil)
      @record_rules = {
        group_code:        {index: 1, validate: :letters},
        group:             {index: 2, validate: :letters, null: true},
        kpi:               {index: 3, validate: :letters},
        date:              {index: 4, validate: :date},
        value:             {index: 5, validate: :letters}
      }

      @file = File.open(file)
      @users = []
      @update_existing = update_existing
      @admin_user = admin_user
      @account = account
      @parsing_errors = []
      @num_rows = 0
      
      raise ArgumentError, "The file doesn't exists" unless File.exists?(@file)
      raise ArgumentError, "Imposible to read the file" unless File.readable?(@file)
      raise ArgumentError, I18n.t('import.text.csv_encoding_error_msg') unless self.check_encoding
    end

    def process()
      if self.check_header
        @import_job = ImportKPIJob.create(
          file: @file.path,
          col_separator: self.col_separator,
          record_rules: @record_rules,
          update_existing: @update_existing,
          creator_user_id: @admin_user.id.to_s,
          account_id: @account.id.to_s,
          length: (@num_rows - 1)
        )   
      end
    ensure
      @file.close
    end

    def check_header()
      if(File.exists?(@file))
        if(File.readable?(@file))
          header = @file.first
          header = header.gsub(/[\r\n\"\']/, '')
          
          @col_separator = self.columns_separator(header)
          
          header_array = header.split(@col_separator)

          if( header_array.is_a?(Array))
            %w[group_code kpi date value].each do |target_column|
              unless header_array.include?(target_column)
                @parsing_errors << [{header_row: "The field #{target_column} must be included on the csv"}, {}]
                return false
              end
            end
          else
            @parsing_errors << [{header_row: "Every field per record must to be separated by comma, semi-colon, or pipe character"}, {}]
            return false
          end 

        else
          @parsing_errors << [{header_row: "Impossible to read the file"}, {}]
          return false
        end 
      else
        @parsing_errors << [{header_row: "File doesn't exists"}, {}]
        return false
      end

      @headers = header_array

      return true
    end

    def columns_separator(line)
      separator = "\n"
      separator = if (line.include? "|" and !(line.include? ";" or line.include? "," or line.include? "\t"))
        '|'
      elsif (line.include? ";" and !(line.include? "|" or line.include? "," or line.include? "\t"))
        ';'
      elsif (line.include? "," and !(line.include? "|" or line.include? ";" or line.include? "\t"))
        ','
      elsif (line.include? "\t" and !(line.include? "|" or line.include? ";" or line.include? ","))
        "\t"
      end
      
    end

    def check_encoding()

      begin
        @num_rows = CSV.read(@file.path, encoding: 'UTF-8').count
      rescue Exception
        return false
      end
    end
      
  end
end
