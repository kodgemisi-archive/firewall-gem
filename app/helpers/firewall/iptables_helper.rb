require 'firewall/config'

module Firewall
  module IptablesHelper

    class NotSudoException < StandardError
    end

    class << self

      def gain_sudo
        @password = Config.sudo_password
        io = IO.popen(["sudo", "-S", 'pwd'], mode="a+")

        io.write("#{@password}\n")
        io.write("#{@password}\n")
        io.write("#{@password}\n")

        l = io.readlines

        if(l.size == 0)
          raise NotSudoException.new
        end
      end

      def add_rule(rule)
        gain_sudo()
        puts "add_rule #{rule}"
        rule_array = rule.split(' ')
        f = IO.popen(['sudo', '-n', 'iptables'] + rule_array, :err=>[:child, :out])
        return f.readlines.join
      end

      def remove_rule(linenumber, chain="INPUT")
        gain_sudo()
        f = IO.popen(['sudo', '-n', 'iptables', '-D', "#{chain}", "#{linenumber}"], :err=>[:child, :out])
        return f.readlines.join
      end

      def blacklist_ip(ip, blacklist_name='blacklist')
        gain_sudo()
        #FIXME: check if ip only consists of numbers and '.'
        #FIXME: check if blacklist_name only consists of alphanumerics and has no ';'
        return system "sudo sh -c \'echo \"+#{ip}\" >> /proc/net/xt_recent/#{blacklist_name}\'"
      end

      def unblacklist_ip(ip, blacklist_name='blacklist')
        gain_sudo()
        #FIXME: check if ip only consists of numbers and '.'
        #FIXME: check if blacklist_name only consists of alphanumerics and has no ';'
        return system "sudo sh -c \'echo \"-#{ip}\" >> /proc/net/xt_recent/#{blacklist_name}\'"
      end

      def show_rules
        gain_sudo()
        f = IO.popen(['sudo', '-n', 'iptables', '-n', '-L', '--line-numbers'], :err=>[:child, :out])
        result = f.readlines.join
        return result
      end

      def blacklisted_ips(blacklist_name='blacklist')
        f = IO.popen(['cat', "#{blacklist_name}"], :err=>[:child, :out])
        return f.readlines.join
      end

      def reset_rules
        gain_sudo

        system("sudo iptables -F")
        system("sudo iptables -X")
        system("sudo iptables -t nat -F")
        system("sudo iptables -t nat -X")
        system("sudo iptables -t mangle -F")
        system("sudo iptables -t mangle -X")
        system("sudo iptables -P INPUT ACCEPT")
        system("sudo iptables -P FORWARD ACCEPT")
        system("sudo iptables -P OUTPUT ACCEPT")
      end

      def get_rules()
        f = IO.popen(['sudo', 'iptables-save'], :err=>[:child, :out])
        return f.readlines.join
      end

      # This method overrides all existing rules
      def apply_rules(all_rules_as_string)
        reset_rules()

        #sudo already gained in reset
        f = IO.popen(['sudo', 'iptables-restore'], mode="a+", :err=>[:child, :out])
        f.write(all_rules_as_string)
        f.close
      end

    end
  end
end