# frozen_string_literal: true

require './email.rb'

class MailboxTextFormatter
  M = ' '
  COLUMNS = 3
  def initialize(mailbox)
    @mailbox = mailbox
    # #@date_length = mailbox.emails
    # @subject_length = mailbox.longest_subject.length  # => 22
    # mailbox.longest_subject  # => "Re: Homework this week"
    # @date
  end

  def format
    subject_length = @mailbox.max_length('subject') # => "Re: Homework this week"
    date_length = @mailbox.max_length('date')  # => "2020-01-01"
    from_length = @mailbox.max_length('from')  # => "Melvin"

    puts
    puts "Mailbox: #{@mailbox.name}"
    total_length = (COLUMNS + 1 ) + (COLUMNS * M.length * 2) + subject_length + date_length + from_length
    print '+' + '-' * (date_length + 2) + "+" + '-' * (from_length + 2)
    print '+' + '-' * (subject_length + 2) + "+\n"

    print '|' + M + 'Date' + (' ' * ('Date'.length- date_length).abs) + M
    print '|' + M + 'From'+ (' ' * ('From'.length - from_length).abs) + M
    print '|' + M + 'Subject'+ (' ' * ('Subject'.length - subject_length).abs) + M + "|\n" # =>

    print '+' + '-' * (date_length + 2) + "+" + '-' * (from_length + 2)
    print '+' + '-' * (subject_length + 2) + "+\n"
    @mailbox.each do |email|
      print '|' + M + email.date + (' ' * (date_length - email.date.length)) + M
      print '|' + M + email.from + (' ' * (from_length - email.from.length)) + M
      print '|' + M + email.subject + (' ' * (subject_length - email.subject.length)) + M + "|\n" # =>
    end
    print '+' + '-' * (date_length + 2) + "+" + '-' * (from_length + 2)
    print '+' + '-' * (subject_length + 2) + "+\n"
  end
end

emails = [
  Email.new('Hello', date: '2020-01-01', from: 'Melvin'),
  Email.new('Keep on coding! :)', date: '2014-12-01', from: 'Dajana'),
  Email.new('Re: Homework this week', date: '2014-12-02', from: 'Ariane')
]
mailbox = Mailbox.new('Ruby Study Group', emails)

formatter = MailboxTextFormatter.new(mailbox)

puts formatter.format

# >> Melvin
