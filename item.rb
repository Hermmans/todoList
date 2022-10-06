class Item 
    attr_accessor :title, :description
    attr_reader :deadline, :done
    def valid_date?(data_string)
       new_data = data_string.split("-") 
      return false if new_data.length != 3
         return true if new_data[0].length == 4 && (1..12).include?(new_data[1].to_i) && (1..31).include?(new_data[2].to_i)
         false  
    end
    def initialize(title, deadline, description=nil)
        @title = title
        @deadline = deadline
        description ||= nil
        @description = description
        @done = false 
            raise "error due to invalid date" if valid_date?(@deadline) == false 
    end
    def deadline=(new_deadline)
        raise "error due to invalid date" if !valid_date?(new_deadline)
        @deadline = new_deadline
    end
    def toggle
        @done = true
    end 
end