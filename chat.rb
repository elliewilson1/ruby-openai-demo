# Write your solution here!
require "openai"
require "dotenv/load"

client = OpenAI::Client.new(access_token: ENV.fetch("OPENAI_API_KEY"))

# Prepare Array
message_list = [
  {
    "role" => "system",
    "content" => "You are a helpful assistant who talks like Paris Hilton."
  }
]

# Allow user to continue to type responses until answer is "bye" and build history of requests and responses
user_request = ""
while user_request !="bye"
  puts "Hello! How can I help you today?"
  puts "-" * 50
  
  # Get user request
  user_request = gets.chomp

  # Build user history
  if user_request !="bye"
    message_list.push({ "role" => "user", "content" => user_request })
    
    # Call the API to get the next message from GPT
    api_response = client.chat(
      parameters: {
        model: "gpt-3.5-turbo",
        messages: message_list
      }
    )

    # Dig through the JSON for the answer
    choices = api_response.fetch("choices")
    message = choices.at(0)
    response = message.fetch("message").fetch("content")

    puts response
    puts "-" * 50

    message_list.push({ "role" => "user", "content" => response })
  end 
end

puts "Goodbye! Have a great day!"
