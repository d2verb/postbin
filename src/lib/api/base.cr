require "http/client"

module BaseAPI
  record Response, status_code : Int32, body : String, err : Exception | Nil

  URL = "https://postb.in/api/bin"

  macro http_method(name)
    def self.{{name}}(url)
      res = HTTP::Client.{{name}} url
      Response.new(res.status_code.to_i, res.body, nil)
    rescue ex
      Response.new(0, "", ex)
    end
  end

  http_method get
  http_method post
  http_method delete
end
