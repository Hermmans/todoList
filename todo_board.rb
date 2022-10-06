require_relative 'list.rb'
class Todo_board
    def initialize
        @hash = {}
        @hash.each {|k,v| k[v] = [] }
           
    end
    def get_command
        print "\nEnter a command: "
        cmd, list, *args = gets.chomp.split(' ')
        case cmd
        when 'mklist'
            @hash[list] = List.new(list)
        when 'purge'
            @hash[list].purge
        when 'toggle'
            @hash[list].toggle_item(args.join.to_i)
        when 'rm'
            @hash[list].remove_item(args.join.to_i)
        when 'print'
           return  @hash[list].print if args.empty?
            @hash[list].print_full_item(args.join.to_i) 
        when 'priority'
            @hash[list].print_priority
        when 'sort'
            @hash[list].sort_by_date!
        when 'swap'
            @hash[list].swap(args[0].to_i, args[1].to_i)
        when 'down'
                @hash[list].down(args[0].to_i) if args.length <= 1
            @hash[list].down(args[0].to_i, args[1].to_i)
        when 'up'
                @hash[list].up(args[0].to_i) if args.length <= 1
            @hash[list].up(args[0].to_i, args[1].to_i)
        when 'mktodo'
            @hash[list].add_item(*args)
        
        when 'ls'
            puts @hash.keys
        when 'showall'
            @hash.keys.each { |k| puts @hash[k].print}
        when 'quit'
            return false
        else
            print "Sorry, that command is not recognized."
        end
        true
end
def run 
    until self.get_command == false
           self.get_command
    end
end
end
   