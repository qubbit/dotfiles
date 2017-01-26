# === EDITOR ===
Pry.editor = 'vim'

# == Pry-Nav - Using pry as a debugger ==
Pry.commands.alias_command 'c', 'continue' rescue nil
Pry.commands.alias_command 's', 'step' rescue nil
Pry.commands.alias_command 'n', 'next' rescue nil
Pry.commands.alias_command 'r!', 'reload!' rescue nil

Pry.config.color = true
Pry.config.theme = "solarized"

# === CUSTOM PROMPT ===
# # This prompt shows the ruby version (useful for RVM)
Pry.prompt = [proc { |obj, nest_level, _| "pry (ruby #{RUBY_VERSION}) (#{obj}):#{nest_level} > " }, proc { |obj, nest_level, _| "(#{obj}):#{nest_level} * " }]

require 'json'
def json_pp(json)
  puts JSON.pretty_generate(JSON.parse(json))
end

# just my caller
# filter out the call stack to only show
# code that is not inside a vendor directory
# this filters out a lot of noise
# usage: jmc caller
def jmc(stack)
  stack.select{|x| !x.include?("/vendor/") }
end
