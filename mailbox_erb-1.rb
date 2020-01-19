# frozen_string_literal: true

# http://webapps-for-beginners.rubymonstas.org/exercises/mailbox_erb.html 
# ruby monstas erb exercise
#
require './emailHTMLformat.rb'
require 'erb'

TEMPLATE= %(<html>
  <head>
    <style>
      table {
        border-collapse: collapse;
      }
      td, th {
        border: 1px solid black;
        padding: 1em;
      }
    </style>
  </head>
  <body>
    <h1><%=self.name %></h1>
    <table>
      <thead>
        <tr>
          <th>Date</th>
          <th>From</th>
          <th>Subject</th>
        </tr>
      </thead>
      <tbody>
        <% @emails.each do |email| %>
          <tr>
            <td><%= email.date %></td>
            <td><%= email.from %></td>
            <td><%= email.subject %></td>
          </tr>
        <% end %>
      </tbody>
    </table>
  </body>
</html>)

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

  def save_html(filename)
    formatter = MailboxHtmlFormatter.new(self)

    File.open(filename, 'w') do |f|
      f.write(formatter.format)
    end
  end
  def save_html_erb(filename)
    html = to_html
    File.open(filename, 'w') { |f| f.write(html) }
  end
  def to_html
    html = ERB.new(TEMPLATE).result(binding)
  end

end
class MailboxErbRenderer
  def initialize(mailbox, erb_file)
    @mailbox = mailbox
    @erb_file = erb_file
  end
  def render
    erb_data = File.open(@erb_file).read

    html = ERB.new(erb_data).result(binding)
  end

end



emails = [
  Email.new('Hello', date: '2020-01-01', from: 'Melvin'),
  Email.new('Keep on coding! :)', date: '2014-12-01', from: 'Dajana'),
  Email.new('Re: Homework this week', date: '2014-12-02', from: 'Ariane')
]
mailbox = Mailbox.new('Ruby Study Group', emails)
renderer = MailboxErbRenderer.new(mailbox, 'mailbox.erb')
html = renderer.render
puts html

#mailbox.save_html_erb('erb_emails.html')
