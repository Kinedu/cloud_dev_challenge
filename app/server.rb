require 'sinatra'
require 'rubygems'
require 'aws-record'
require_relative "models/landpage_lead.rb"

# autoload :LandpageLead, File.join(File.dirname(__FILE__),'models','landpage_lead.rb')


before do
  if (! request.body.read.empty? and request.body.size > 0)
    request.body.rewind
    @params = Sinatra::IndifferentHash.new
    @params.merge!(JSON.parse(request.body.read))
  end
end

##################################
# For the index page
##################################
get '/' do
  erb :index
end


get '/api/lead' do
  content_type :json
  items = LandpageLead.scan()
  items
    .map { |r| { :email => r.email, :company_industry => r.company_industry } }
    .sort { |a, b| a[:created_at] <=> b[:created_at] }
    .to_json
end

post '/api/lead' do
  content_type :json
  item = LandpageLead.new(id: SecureRandom.uuid, created_at: Time.now, updated_at: Time.now )
  item.first_name = params[:first_name]
  item.last_name = params[:last_name]
  item.phone = params[:phone]
  item.email = params[:email]
  item.company_name = params[:company_name]
  item.company_industry = params[:company_industry]
  item.save! # raise an exception if save fails
  item.to_h.to_json
end


##################################
# Web App with a DynamodDB table
##################################

# Class for DynamoDB table
# This could also be another file you depend on locally.
class FeedbackServerlessSinatraTable
  include Aws::Record
  string_attr :id, hash_key: true
  string_attr :name
  string_attr :feedback
  epoch_time_attr :ts
end



get '/feedback' do
  erb :feedback
end

get '/api/feedback' do
  content_type :json
  items = FeedbackServerlessSinatraTable.scan()
  items
    .map { |r| { :ts => r.ts, :name => r.name, :feedback => r.feedback } }
    .sort { |a, b| a[:ts] <=> b[:ts] }
    .to_json
end

post '/api/feedback' do
  content_type :json
  item = FeedbackServerlessSinatraTable.new(id: SecureRandom.uuid, ts: Time.now)
  item.name = params[:name]
  item.feedback = params[:feedback]
  item.save! # raise an exception if save fails

  item.to_h.to_json
end
