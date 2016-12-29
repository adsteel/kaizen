module Components.StoryList exposing (..)

import Story
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
  { stories : List Story.Model }

initialModel : Model
initialModel =
  { stories = [] }


-- VIEW

view : Model -> Html Msg
view model =
  div [ class "story-list" ]
    [ h2 [] [ text "Stories" ]
    , button [ onClick Fetch, class "btn btn-primary" ] [ text "Fetch Stories" ]
    , ul [] (renderStories model) ]

renderStory : Story.Model -> Html a
renderStory story =
  li [] [ Story.view story ]

renderStories : Model -> List (Html a)
renderStories model =
  List.map renderStory model.stories


-- UPDATE

type Msg
  = NoOp
  | Fetch
  | FetchSucceed (List Story.Model)
  | FetchFail Http.Error

update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
  case msg of
    NoOp ->
      (model, Cmd.none)
    Fetch ->
      (model, fetchStorys)
    FetchSucceed storyList ->
      (Model storyList, Cmd.none)
    FetchFail error ->
      case error of
        Http.UnexpectedPayload errorMessage ->
          Debug.log errorMessage
          (model, Cmd.none)
        _ ->
          (model, Cmd.none)


-- HTTP calls

fetchStorys : Cmd Msg
fetchStorys =
  let
    url = "/api/projects/1/stories"
  in
    Task.perform FetchFail FetchSucceed (Http.get decodeStoryFetch url)

decodeStoryFetch : Json.Decoder (List Story.Model)
decodeStoryFetch =
  Json.at ["data"] decodeStoryList

decodeStoryList : Json.Decoder (List Story.Model)
decodeStoryList =
  Json.list decodeStoryData

decodeStoryData : Json.Decoder Story.Model
decodeStoryData =
  Json.object5 Story.Model
    ("creator" := Json.string)
    ("description" := Json.string)
    ("id" := Json.string)
    ("status" := Json.string)
    ("story_type" := Json.string)
