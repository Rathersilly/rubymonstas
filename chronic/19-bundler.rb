require "chronic"

time = Chronic.parse('tomorrow')
p time.class
p time
time = Chronic.parse('tomorrow')
puts time.month

