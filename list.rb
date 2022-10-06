require_relative 'item.rb'
class List 
    attr_accessor :label
    def initialize(label)
        @label = label 
        @items = []
    end
    def add_item(title, deadline, description=nil)
        description ||= nil 
        if description == nil
            @items << Item.new(title, deadline)
        else
            @items <<  Item.new(title , deadline, description)
        end
    end
    def size
        @items.length
    end
    def valid_index(index)
      (0...@items.length).include?(index)
    end
    def swap(index_1, index_2)
        return false if valid_index(index_1) == false || valid_index(index_2) == false
               @items[index_1] , @items[index_2] = @items[index_2] , @items[index_1]
        true
     end
    def [](index)
       return nil if  self.valid_index(index) == false
       @items[index]
    end
    def priority
        @items[0]
    end 
    def print 
        default = "-" * 49 +"\n"
        str = ""
        str += default +" " * 17 + "#{@label.upcase}\n"+default
        str += "Index |" + " Item".ljust(22," ") +"|"" Deadline".ljust(13," ") +"| Done\n" + default
        @items.each_with_index do |s, idx|
    str+= "#{idx}".ljust(6," ") + "|" + " #{s.title}".ljust(22," ") + "|"" #{s.deadline}".ljust(13," ")
            if s.done == true
                str += "| [✓]\n"
            else 
                str += "| [ ]\n"
            end
            
        end
       str +=  default
       puts str
    end
    def print_full_item(index)
        default = "-" * 42 +"\n"
        empty_str = ""
        @items.each_with_index do |s, idx|
            if idx == index
                empty_str += "#{default}" + "#{s.title}".ljust(32," ")+"#{s.deadline}"
                empty_str += "\n#{s.description}".ljust(32," ")
                 if s.done == true
                empty_str += " [✓]\n"+default
            else 
                empty_str += " [ ]\n"+default
            end 
            end
        end
        puts empty_str
    end
   def  print_priority
         print_full_item(0)
    end
    def up(index, amount=nil)
        return false if self[index] == nil    
        amount ||= nil
        return false  if index == 0 
           return swap((index),(index - 1)) if amount == nil 
           count =  0 
           current = index
        until current == 0 || count  == amount  
            current -= count 
            swap(current,current - 1 ) 
            count += 1
        end
        swap(current + 1 , current) if current == 0 
    end
    def down(index, amount=nil)
        return false if self[index] == nil
        return false if index >= self.size - 1
        amount ||= nil
        current = index 
        count = 0
        return swap(current, current + 1) if amount == nil 
        until current == self.size - 1 || count == amount
            swap(current, current + 1) 
            count += 1
            current += 1
        end
    end
    def sort_by_date!
        @items.sort_by! {|list| list.deadline}
    end
    def toggle_item(index)
        @items[index].toggle
    end
    def remove_item(index)
        @items.delete_at(index)
    end
    def purge
        @items.delete_if {|s| s.done == true }
    end
end