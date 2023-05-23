module Peplum
class Template
module Services

class MyService

  def foo
    'bar'
  end

  def shared_hash_to_hash
    Template::Application.shared_hash.to_h
  end

end


end
end
end
