# frozen_string_literal: true

# http://ruby-for-beginners.rubymonstas.org/exercises/mailbox.html
# from ruby monstas exercises
require './emailHTMLformat.rb'
require 'csv'

class Email
  attr_accessor :subject, :date, :from
  def initialize(subject, headers)
    @subject = subject
    @date = headers[:date]
    @from = headers[:from]
  end

  def show
    puts "Date: #{@date}"
    puts "From: #{@from}"
    puts "Subject: #{@subject}"
  end
end

class Mailbox
  include Enumerable

  attr_accessor :name, :emails
  def initialize(name, emails)
    @name = name
    @emails = emails
  end

  def each
    @emails.each do |email|
      yield email
    end
    nil
  end

  def max_length(thing)
    @max_length = 0 # =>
    @emails.each do |email|
      if email.send(thing).length > @max_length
        @max_length = email.send(thing).length # =>

      end
    end
    @max_length
  end

  def save_html(filename)
    formatter = MailboxHtmlFormatter.new(self)

    File.open(filename, 'w') do |f|
      f.write(formatter.format)
    end
  end

  def load_csv(filename)
    data = CSV.read(filename)
    data.shift
    data.each do |row|
      headers = { date: row[0], from: row[1] }
      @emails << Email.new(row[2], headers)
    end
  end
end

emails = [
  Email.new('Hello', date: '2020-01-01', from: 'Melvin'),
  Email.new('Keep on coding! :)', date: '2014-12-01', from: 'Dajana'),
  Email.new('Re: Homework this week', date: '2014-12-02', from: 'Ariane')
]
mailbox = Mailbox.new('Ruby Study Group', emails)
mailbox.load_csv('emails.csv')
p mailbox.emails
mailbox.save_html('emails.hmtl')
if $PROGRAM_NAME == __FILE__
  mailbox.emails.each do |email|
    email.show
    puts
  end
end

# >> Date: 2020-01-01
# >> From: Melvin
# >> Subject: Hello
# >>
# >> Date: 2014-12-01
# >> From: Dajana
# >> Subject: Keep on coding! :)
# >>
# >> Date: 2014-12-02
# >> From: Ariane
# >> Subject: Re: Homework this week
# >>
