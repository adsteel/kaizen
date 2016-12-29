module Kaizen exposing (..)

import Html exposing (..)
import Html.Attributes exposing(class)
import Html.App
import Html.Events exposing (onClick)
import Components.StoryList as StoryList

main : Program Never
main =
  Html.App.program
    { init = init
    , view = view
    , update = update
    , subscriptions = subscriptions
    }


-- MODEL

type alias Model =
  { storyListModel: StoryList.Model }

initialModel : Model
initialModel =
  { storyListModel = StoryList.initialModel }

init : (Model, Cmd Msg)
init =
  ( initialModel, Cmd.none )


-- UPDATE

type Msg
  = StoryListMsg StoryList.Msg

update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
  case msg of
    StoryListMsg storyMsg ->
      let (updatedModel, cmd) = StoryList.update storyMsg model.storyListModel
      in ( { model | storyListModel = updatedModel }, Cmd.map StoryListMsg cmd )


-- SUBSCRIPTIONS

subscriptions : Model -> Sub Msg
subscriptions model =
  Sub.none


-- VIEW
view : Model -> Html Msg
view model =
  div [ class "elm-app" ]
    [ Html.App.map StoryListMsg (StoryList.view model.storyListModel) ]
