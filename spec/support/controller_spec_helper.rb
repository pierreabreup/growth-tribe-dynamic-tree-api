module ControllerSpecHelper
  def json_data
    JSON.parse(response.body)
  end

end
