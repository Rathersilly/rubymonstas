require "json"

# json is good place to use Alternative Syntax %<delimiter>content<delimiter>
# for strings as in the data2 example below
#
data = '{
  "emails": [
    {
      "subject": "Hi there, Ruby Monstas!",
      "date": "2015-01-02",
      "from": "Ferdous"
    },
    {
      "subject": "Keep on coding!",
      "date": "2015-01-03",
      "from": "Dajana"
    }
  ]
}'

data2 = %({
  "emails": [
    {
      "subject": "Hi there, Ruby Monstas!",
      "date": "2015-01-02",
      "from": "Ferdous"
    },
    {
      "subject": "Keep on coding!",
      "date": "2015-01-03",
      "from": "Dajana"
    }
  ]
})
data = JSON.parse(data)

p data
p data.keys

p data["emails"].first["subject"]

