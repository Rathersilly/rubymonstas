require './email.rb'
class MailboxHtmlFormatter
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
THEAD = "      <thead>
      <tr>
        <th>Date</th>
        <th>From</th>
        <th>Subject</th>
        </tr>
      </thead>\n"
EMAIL_ROW = "<tr>
<td></td>
<td></td>
<td></td>
</tr>\n"

  def initialize(mailbox)
    @mailbox = mailbox
  end

  def format
    html = "<html>\n"
    html += HEAD
    html += "  <body>\n"
    html += "    <h1>#{@mailbox.name}</h1>\n"
    html += "    <table>\n"
    html += THEAD
    html += "      <tbody>\n"
    
    
    email_row = ""
    @mailbox.each do |email|
      email_row = "        <tr>\n" + 
                "          <td>#{email.date}</td>\n" +
                "          <td>#{email.from}</td>\n" +
                "          <td>#{email.subject}</td>\n" +
                "        </tr>\n"
      html += email_row
    end 
    
    html += "      </tbody>\n"
    html += "    </table>\n"
    html += "  </body>\n"
    html += '</html>'

    html
  end



end

emails = [
  Email.new('Hello', date: '2020-01-01', from: 'Melvin'),
  Email.new('Keep on coding! :)', date: '2014-12-01', from: 'Dajana'),
  Email.new('Re: Homework this week', date: '2014-12-02', from: 'Ariane')
]
mailbox = Mailbox.new('Ruby Study Group', emails)

formatter = MailboxHtmlFormatter.new(mailbox)

puts formatter.format
