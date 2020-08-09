require "./base"
require "json"

module PostbinAPI
  class APIException < Exception; end

  def self.create : String
    res = BaseAPI.post BaseAPI::URL
    if res.status_code != 201
      raise APIException.new "request failed: #{res.to_s}"
    end
    bin = JSON.parse res.body
    bin["binId"].to_s
  end

  def self.delete(bin_id : String)
    res = BaseAPI.delete "#{BaseAPI::URL}/#{bin_id}"
    if res.status_code != 200
      raise APIException.new "request failed: #{res.to_s}"
    end
  end

  def self.shift(bin_id : String) : Hash(Symbol, String) | Nil
    res = BaseAPI.get "#{BaseAPI::URL}/#{bin_id}/req/shift"
    case res.status_code
    when 500
      raise APIException.new "request failed: #{res.to_s}"
    when 404
      if res.body.includes?("No such bin")
        raise APIException.new "request failed: #{res.to_s}"
      end
      return nil
    end
    info = JSON.parse res.body
    {
      method:  info["method"].to_s,
      path:    info["path"].to_s,
      headers: info["headers"].to_s,
      query:   info["query"].to_s,
      body:    info["body"].to_s,
      ip:      info["ip"].to_s,
    }.to_h
  end
end
