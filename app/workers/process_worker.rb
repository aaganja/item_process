require 'json'
require 'httparty'

class ProcessWorker
  include Sidekiq::Worker
  include HTTParty
  base_uri 'https://development.avalara.net'

  def initialize
    @auth ={:username => "kuberaaganja@gmail.com",:password => "Nepasoft!23"}
  end

  def perform(process_id)
  	vtp = Valuetoprocess.find(process_id)
  	@url = "/1.0/tax/get"
    @request_body =vtp.value

    response = self.class.post(@url,
                             :basic_auth => @auth,
                             :body =>  @request_body,
                             :options => {
                                 :headers => { "ContentType" => "application/json" }
                                          }
                            )

    response.body
  end
end