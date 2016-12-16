defmodule Kaizen.UserView do
  use Kaizen.Web, :view

  def render("articles.json", _params) do
    %{
        data: [
          %{ title: "Article 1 son", url: "http://google.com", postedBy: "Author 1", postedOn: "06/21/16" },
          %{ title: "Article 2 son", url: "http://google.com", postedBy: "Author 2", postedOn: "06/22/16" },
          %{ title: "Article 3 son", url: "http://google.com", postedBy: "Author 3", postedOn: "06/23/16" }
        ]
      }
  end
end
