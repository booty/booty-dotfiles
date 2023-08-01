# frozen_string_literal: true

#
# require "dotiw"

puts "Loaded .pryrc! 🤟"
if defined?(PryByebug)
  Pry.commands.alias_command "c", "continue"
  Pry.commands.alias_command "s", "step"
  Pry.commands.alias_command "n", "next"
  Pry.commands.alias_command "f", "finish"
  Pry.commands.alias_command "b", "break"
  Pry.commands.alias_command "bda", "break --disable-all"
  Pry.commands.alias_command "bdac", "break --disable-all; continue"
end

def pbcopy(obj)
  IO.popen("pbcopy", "w") { |pipe| pipe.puts obj }
end

def subl(obj)
  IO.popen("subl", "w") { |pipe| pipe.puts obj }
end

def jstack
  stuff = caller.reject { |x| x["rbenv/versions"] }
  stuff.map { |y| y.gsub(/\/Users\/booty/, "~").gsub(/compliancemate/, "cm") }
end

# -- Booty's stuff -------------------------------------------------------------

def jhash(num: 5, increment: 1)
  key = :a
  (1..num).each_with_object({}) do |x, memo|
    memo[key] = x * increment
    key = key.succ
  end
end

def jary(num: 5, increment: 1, start: 0)
  (0..num - 1).each_with_object(Array.new(num)) do |x, memo|
    memo[x] = start + (x * increment)
  end
end

def jary10; jary(increment: 10, start: 10); end

class Jbo
  TEMPFILE = "/Users/booty/proj/tmp/pry.sql"
  MAX_COLUMN_LENGTH = 40
  VERT_SEP = "|"
  HORIZ_SEP = "-"

  if defined? Rails
    if Rails::VERSION::STRING >= "4"
      # returns an array of routes in Rails 4
      def self.formatted_routes
        r = Rails.application.routes.routes
        i = ActionDispatch::Routing::RoutesInspector.new(r)
        f = ActionDispatch::Routing::ConsoleFormatter.new
        i.format(f).split("\n")
      end
    else
      # returns an array of routes in Rails 3
      require "rails/application/route_inspector"
      def self.formatted_routes
        inspector = Rails::Application::RouteInspector.new
        inspector.format(Rails.application.routes.routes)
      end
    end

    # filter and print out the routes. filter can be string or regex
    def self.routes(filter = nil)
      Rails.application.reload_routes!
      formatted = formatted_routes
      formatted.select! { |r| r.match(filter) } if filter
      puts formatted
    end

    def self.sql(sql = nil, rows = 2)
      unless sql
        `subl --wait #{TEMPFILE}`
        sql = File.read(TEMPFILE)
      end
      results = ActiveRecord::Base.connection.execute(sql)
      print_formatted_results(results, rows)
    end

    def self.print_formatted_results(results, rows)
      results.first(rows).each { |x| ap x }
      return unless results.count > rows

      puts "Got #{results.count} results; displayed #{rows}"
    end

    def self.recordcount
      Rails.application.eager_load!
      ApplicationRecord.
        descendants.
        sort_by(&:name).
        map do |x|
        "#{x.name} (#{begin
          x.count
        rescue StandardError
          'n/a'
        end})"
      end
    end
  end

  def self.format_columns(data, headers: nil, separator: " #{VERT_SEP} ", indent_size: 0)
    data_with_headers = data.prepend(headers) if headers
    # assumes no rows have more items than row 0
    max_data_lengths = Array.new(data[0].length, 0)
    data.each do |row|
      row.each_with_index do |col_value, col_number|
        col_length = [MAX_COLUMN_LENGTH, col_value.to_s.length].min
        max_data_lengths[col_number] = [
          max_data_lengths[col_number],
          col_length,
        ].max
      end
    end

    # Separator row, if needed
    data_with_headers.insert(1, max_data_lengths.map { |i| HORIZ_SEP * i }) if headers

    data.map do |row|
      row_results = []
      row.each_with_index do |col_value, col_number|
        current_col_width = max_data_lengths[col_number]
        truncated_val = col_value.to_s[0..MAX_COLUMN_LENGTH - 1]
        row_results << truncated_val.ljust(current_col_width)
      end
      "#{' ' * indent_size}#{row_results.join(separator)}"
    end.join("\n")
  end

  # For legibility, puts longer items in rightmost columns
  def self.columnify(array, number_of_columns: 3, indent_size: 0)
    number_of_rows = array.length / number_of_columns
    number_of_rows += 1 unless (array.length % number_of_columns).zero?
    sorted = array.sort_by(&:length)
    result = Array.new(number_of_rows) { Array.new(number_of_columns) }
    (0..number_of_columns - 1).each do |column_number|
      (0..number_of_rows - 1).each do |row_number|
        result[row_number][column_number] = sorted.shift
      end
    end
    puts format_columns(
      result,
      separator: "   ",
      indent_size:,
    )
  end

  def self.wrap(s, width: 50, indent_size: 0, preserve_leading_whitespace: false)
    return s if s.length <= width

    output_lines = []

    current_pos = 0
    last_word_start_pos = 0
    line_start_pos = 0

    while current_pos < s.length
      if s[current_pos] == " "
        in_word = false
      else
        last_word_start_pos = current_pos unless in_word
        in_word = true
      end

      # skip whitespace at beginning of line
      if !in_word && (current_pos == line_start_pos) && !preserve_leading_whitespace
        line_start_pos += 1
      end

      if s[current_pos] == "\n"
        output_lines << s[line_start_pos..current_pos - 1]
        line_start_pos = current_pos
        current_pos += 1
      elsif (current_pos - line_start_pos) == width
        next_char_is_whitespace = s[current_pos + 1] == " "

        if !in_word || (in_word && next_char_is_whitespace)
          # we're at the end of a word
          output_lines << s[line_start_pos..current_pos]
          current_pos += 1
        elsif in_word && (line_start_pos == last_word_start_pos)
          output_lines << "#{s[line_start_pos..current_pos - 1]}-"
          in_word = false
          current_pos
        elsif in_word
          output_lines << s[line_start_pos..last_word_start_pos - 1]
          current_pos = last_word_start_pos
        else
          output_lines << s[line_start_pos..current_pos]
          current_pos += 1
        end
        current_pos += 1 if s[current_pos] == " "
        line_start_pos = current_pos
      else
        current_pos += 1
      end
    end
    output_lines << s[line_start_pos..s.length] # if current_pos > s.length
    indent = " " * indent_size
    "#{indent}#{output_lines.join("\n#{indent}")}"
  end
end

# ------------------------------------------------------------------------------

def jsql(sql = nil, rows = 10); Jbo.sql(sql, rows); end
def pryrc; `subl /Users/booty/.pryrc`; end
def lpryrc; load "/Users/booty/.pryrc"; end
def callercm; caller.reverse.select { |c| c =~ /compliancemate/ }; end

# ------------------------------------------------------------------------------

if defined?(ComplianceMate)
  INDENT_SIZE = 2
  INDENT = "  "
  DIVIDER = "-"

  # class List
  #   def debug(location: nil, date: Date.today)
  #     puts Cm::Ui.header("List #{id}: (#{name})")
  #     puts "\n"
  #     puts Cm.render_attributes(group.attributes)
  #     if location
  #       puts Cm.render_ancestry(group, indent_size: INDENT_SIZE * 2)
  #       puts Cm.render_list_completion(
  #         list: self,
  #         location: location,
  #         date: date
  #       )
  #       puts Cm.render_list_instance_and_responses(
  #         list: self,
  #         location: location,
  #         date: date
  #       )
  #     end
  #   end
  # end

  # class Group
  #   def debug(group_or_group_id)
  #     ActiveRecord::Base.logger.silence do
  #       group = Cm.boop(group_or_group_id, Group)
  #       puts Cm::Ui.header("Group #{group.id} (#{group.name})")
  #       puts "\n"
  #       puts Cm.render_attributes(group.attributes)
  #       puts Cm.render_ancestry(group)
  #       puts Cm.render_lists(group)
  #     end
  #   end
  # end

  class Cm
    def self.render_list_completion(list:, location:, date:)
      puts Cm::Ui.subheader("Completion for Location: #{location.id} (#{location.name}) Date: #{date}")
      puts "#{INDENT * 2}#completion_percentage_for(location, date)\n\n"
      puts Cm.render_attributes(
        list.completion_percentage_for(location, date).attributes,
        indent_size: INDENT_SIZE * 2,
      )
      sql = CompletionQueryBuilder.
        new.
        list_percentages_for_all.
        includes(:location).
        where(
          location:,
          date:,
        ).to_sql.delete("\n").gsub(/\s{2,}/, " ")
      puts Jbo.wrap(sql, width: 90, indent_size: INDENT_SIZE * 2)
    end

    def self.render_list_instance_and_responses(list:, location:, date:)
      puts Cm::Ui.subheader("ListInstance")
      li = ListInstance.find_by(list:, location:, date:)
      unless li
        puts "#{INDENT}No list instance!"
        return
      end
      puts Cm.render_attributes(
        li.attributes,
        indent_size: INDENT_SIZE * 2,
      )
      r = Response.where(list_instance: li)
      return if r.none?

      puts Cm::Ui.subheader("Responses")
      r.each do |r|
        puts Cm.render_attributes(
          r.attributes,
          indent_size: INDENT_SIZE * 2,
          omit_null: true,
        )
      end
      puts Cm::Ui.subheader("List Items")
      # TODO: restrict to correct version
      list.list_items.each do |r|
        puts Cm.render_attributes(
          r.attributes,
          indent_size: INDENT_SIZE * 2,
        )
      end
    end

    def self.render_ancestry(group, indent_size: INDENT_SIZE)
      ancestors = group.
        self_and_ancestors.
        includes(:lists, :locations)
      return if ancestors.none?

      puts Cm::Ui.subheader("Ancestry")
      data = ancestors.reverse.map do |g|
        [
          g.id,
          g.name,
          g.locations.map(&:id).join(","),
          g.lists.map(&:id).join(","),
        ]
      end
      headers = %w[id name locations lists]
      puts Jbo.format_columns(data, headers:, indent_size:)
    end

    def self.render_lists(group)
      data = group.inherited_lists.map do |l|
        [
          l.id,
          l.name,
          l.group_id,
        ]
      end
      return if data.none?

      puts Cm::Ui.subheader("Lists")
      headers = %w[id name group_id]
      puts Jbo.format_columns(data, headers:, indent_size: 2)
    end

    # TODO: put long values on separate lines
    # TODO: strip newlines from text fields
    def self.render_attributes(attributes_hash, indent_size: INDENT_SIZE, omit_null: false)
      items = attributes_hash.select do |_k, v|
                v || !omit_null
              end.each_with_object([]) do |keyval, memo|
        memo << "#{keyval[0]}: #{keyval[1]}"
      end
      Jbo.columnify(items, number_of_columns: 3, indent_size:)
    end

    def self.boop(item, klass)
      return item if item.is_a?(klass)

      klass.find(item)
    end

    class Ui
      def self.header(s)
        "#{DIVIDER * INDENT_SIZE} #{s} ".ljust(100, DIVIDER)
      end

      def self.subheader(s)
        "#{INDENT}·· #{s} ··\n\n"
      end
    end
  end
end

# Copyright (c) Conrad Irwin <conrad.irwin@gmail.com> -- MIT License
# Source: https://github.com/ConradIrwin/pry-debundle
#
# To install and use this:
#
# 1. Recommended
#   Add 'pry' to your Gemfile (in the development group)
#   Add 'pry-debundle' to your Gemfile (in the development group)
#
# 2. OK, if colleagues are wary of pry-debundle:
#   Add 'pry' to your Gemfile (in the development group)
#   Copy this file into ~/.pryrc
#
# 3. Meh, if colleagues don't like Pry at all:
#   Copy this file into ~/.pryrc
#   Create a wrapper script that runs `pry -r<your-application>`
#
# 4. Pants, if you don't like Pry:
#   Copy the definition of the debundle! method into your ~/.irbrc
#   Call 'debundle!' from IRB when you need to.
#
class << Pry
  # Break out of the Bundler jail.
  #
  # This can be used to load files in development that are not in your Gemfile (for
  # example if you want to test something with a tool that you have locally).
  #
  # @example
  #   Pry.debundle!
  #   require 'all_the_things'
  #
  # Normally you don't need to cal this directly though, as it is called for you when Pry
  # starts.
  #
  # See https://github.com/carlhuda/bundler/issues/183 for some background.
  #
  def debundle!
    return unless defined?(Bundler)

    loaded = false

    if rubygems_18_or_better?
      if Gem.post_reset_hooks.reject! { |hook| hook.source_location.first =~ %r{/bundler/} }
        # Bundler.preserve_gem_path
        Gem.clear_paths
        Gem::Specification.reset
        remove_bundler_monkeypatches
        loaded = true
      end

    # Rubygems 1.6 — TODO might be quite slow.
    elsif Gem.source_index && Gem.send(:class_variable_get, :@@source_index)
      Gem.source_index.refresh!
      remove_bundler_monkeypatches
      loaded = true

    else
      raise "No hacks found :("
    end
  rescue StandardError => e
    puts "Debundling failed: #{e.message}"
    puts "When reporting bugs to https://github.com/ConradIrwin/pry-debundle, please include:"
    puts "* gem version: #{begin
      Gem::VERSION
    rescue StandardError
      'undefined'
    end}"
    puts "* bundler version: #{begin
      Bundler::VERSION
    rescue StandardError
      'undefined'
    end}"
    puts "* pry version: #{begin
      Pry::VERSION
    rescue StandardError
      'undefined'
    end}"
    puts "* ruby version: #{begin
      RUBY_VERSION
    rescue StandardError
      'undefined'
    end}"
    puts "* ruby engine: #{begin
      RUBY_ENGINE
    rescue StandardError
      'undefined'
    end}"
  else
    load_additional_plugins if loaded
  end

  # After we've escaped from Bundler we want to look around and find any plugins the user
  # has installed locally but not added to their Gemfile.
  #
  def load_additional_plugins
    old_plugins = Pry.plugins.values
    Pry.locate_plugins
    new_plugins = Pry.plugins.values - old_plugins

    new_plugins.each(&:activate!)
  end

  private

  def rubygems_18_or_better?
    defined?(Gem.post_reset_hooks)
  end

  def rubygems_20_or_better?
    Gem::VERSION.to_i >= 2
  end

  # Ugh, this stuff is quite vile.
  def remove_bundler_monkeypatches
    if rubygems_20_or_better?
      load "rubygems/core_ext/kernel_require.rb"
    else
      load "rubygems/custom_require.rb"
    end

    if rubygems_18_or_better?
      Kernel.module_eval do
        # :doc:
        def gem(gem_name, *requirements)
          skip_list = (ENV["GEM_SKIP"] || "").split(/:/)
          raise Gem::LoadError, "skipping #{gem_name}" if skip_list.include? gem_name

          spec = Gem::Dependency.new(gem_name, *requirements).to_spec
          spec&.activate
        end
      end
    else
      Kernel.module_eval do
        # :doc:
        def gem(gem_name, *requirements)
          skip_list = (ENV["GEM_SKIP"] || "").split(/:/)
          raise Gem::LoadError, "skipping #{gem_name}" if skip_list.include? gem_name

          Gem.activate(gem_name, *requirements)
        end
      end
    end
  end
end

# Run just after a binding.pry, before you get dumped in the REPL.
# This handles the case where Bundler is loaded before Pry.
# NOTE: This hook happens *before* :before_session
Pry.config.hooks.add_hook(:when_started, :debundle) do
  Pry.debundle!

  begin
    require "awesome_print"
    Pry.config.print = proc { |output, value| output.puts value.ai }
  rescue LoadError
    puts "no awesome_print :("
  end

  #   begin
  #     require 'hirb'
  #   rescue LoadError
  #     puts ".pryrc: hirb not installed (try 'gem install hirb')"
  #   end

  # from https://github.com/pry/pry/wiki/FAQ#awesome_print
  # if defined? Hirb
  #   puts "FUCKYEAH"
  #   # Slightly dirty hack to fully support in-session Hirb.disable/enable toggling
  #   Hirb::View.instance_eval do
  #     def enable_output_method
  #       @output_method = true
  #       @old_print = Pry.config.print
  #       Pry.config.print = proc do |*args|
  #         Hirb::View.view_or_page_output(args[1]) || @old_print.call(*args)
  #       end
  #     end

  #     def disable_output_method
  #       Pry.config.print = @old_print
  #       @output_method = nil
  #     end
  #   end

  #   Hirb.enable
  # end
end

# Run after every line of code typed.
# This handles the case where you load something that loads bundler
# into your Pry.
Pry.config.hooks.add_hook(:after_eval, :debundle) { Pry.debundle! }
