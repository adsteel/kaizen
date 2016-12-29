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


-- VIEW

view : Model -> Html Msg
view model =
  div [ class "story-list" ]
    [ h2 [] [ text "Stories" ]
    , button [ onClick Fetch, class "btn btn-primary" ] [ text "Fetch Stories" ]
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
    url = "/api/projects/1/stories"
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
  Json.object5 Article.Model
    ("creator" := Json.string)
    ("description" := Json.string)
    ("id" := Json.string)
    ("status" := Json.string)
    ("story_type" := Json.string)
