# frozen_string_literal: true

#require './email.rb'

HEAD = "  <head>
    <style>
      table {
        border-collapse: collapse;
      }
      td, th {
        border: 1px solid black;
        padding: 1em;
      }
    </style>
  </head>\n"
class MailboxHtmlFormatter
  def initialize(mailbox)
    @mailbox = mailbox
  end

  def format
    tag(:html, [HEAD, body].join("\n"))
  end

  def body
    tag(:body, [headline, table].join("\n"))
  end

  def headline
    tag(:h1, @mailbox.name)
  end

  def table
    tag(:table, [thead, tbody].join("\n"))
  end

  def thead
    tag(:thead, ths.join("\n"))
  end

  def ths
    headers = %w[Date From Subject]
    headers.map { |content| tag(:th, content) }
  end

  def tbody
    tag(:tbody, trs.join("\n"))
  end

  def trs
    rows.map { |row| tr(row) }
  end

  def tr(row)
    tag(:tr, tds(row).join("\n"))
  end

  def tds(row)
    row.collect { |content| tag(:td, content) }
  end

  def indent(html)
    lines = html.split("\n")
    lines = lines.map { |line| ' ' * 2 + line }
    lines.join("\n")
  end

  def rows
    @mailbox.emails.collect do |email|
      [email.date, email.from, email.subject]
    end
  end

  def tag(name, content)
    content = "\n#{content}\n" unless %i[h1 td th].include?(name)
    html = "<#{name}>#{content}</#{name}>"
    html = indent(html) unless name == :html
    html
  end
end

=begin
emails = [
  Email.new('Hello', date: '2020-01-01', from: 'Melvin'),
  Email.new('Keep on coding! :)', date: '2014-12-01', from: 'Dajana'),
  Email.new('Re: Homework this week', date: '2014-12-02', from: 'Ariane')
]
mailbox = Mailbox.new('Ruby Study Group', emails)

formatter = MailboxHtmlFormatter.new(mailbox)


mailbox.save("emails.hmtl")
puts formatter.format
=end
