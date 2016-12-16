module Components.ArticleList exposing (..)

import Article
import Debug
import Html exposing (Html, text, ul, li, div, h2, button)
import Html.Attributes exposing (class)
import Html.Events exposing (onClick)
import Http
import Json.Decode as Json exposing ((:=))
import List
import Task

-- MODEL

type alias Model =
  { articles : List Article.Model }

initialModel : Model
initialModel =
  { articles = [] }

articles : Model
articles =
  { articles =
    [ { title = "Article 1", url = "http://google.com", postedBy = "Author 1", postedOn = "06/21/16" }
    , { title = "Article 2", url = "http://google.com", postedBy = "Author 2", postedOn = "06/22/16" }
    , { title = "Article 3", url = "http://google.com", postedBy = "Author 3", postedOn = "06/23/16" } ]
  }


-- VIEW

view : Model -> Html Msg
view model =
  div [ class "article-list" ]
    [ h2 [] [ text "Article List" ]
    , button [ onClick Fetch, class "btn btn-primary" ] [ text "Fetch Articles" ]
    , ul [] (renderArticles model) ]

renderArticle : Article.Model -> Html a
renderArticle article =
  li [] [ Article.view article ]

renderArticles : Model -> List (Html a)
renderArticles model =
  List.map renderArticle model.articles


-- UPDATE

type Msg
  = NoOp
  | Fetch
  | FetchSucceed (List Article.Model)
  | FetchFail Http.Error

update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
  case msg of
    NoOp ->
      (model, Cmd.none)
    Fetch ->
      (model, fetchArticles)
    FetchSucceed articleList ->
      (Model articleList, Cmd.none)
    FetchFail error ->
      case error of
        Http.UnexpectedPayload errorMessage ->
          Debug.log errorMessage
          (model, Cmd.none)
        _ ->
          (model, Cmd.none)


-- HTTP calls

fetchArticles : Cmd Msg
fetchArticles =
  let
    url = "/api/articles"
  in
    Task.perform FetchFail FetchSucceed (Http.get decodeArticleFetch url)

decodeArticleFetch : Json.Decoder (List Article.Model)
decodeArticleFetch =
  Json.at ["data"] decodeArticleList

decodeArticleList : Json.Decoder (List Article.Model)
decodeArticleList =
  Json.list decodeArticleData

decodeArticleData : Json.Decoder Article.Model
decodeArticleData =
  Json.object4 Article.Model
    ("title" := Json.string)
    ("url" := Json.string)
    ("postedBy" := Json.string)
    ("postedOn" := Json.string)
