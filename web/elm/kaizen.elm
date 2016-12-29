module Kaizen exposing (..)

import Html exposing (..)
import Html.Attributes exposing(class)
import Html.App
import Html.Events exposing (onClick)
import Components.StoryList as StoryList
import Json.Decode exposing ((:=))

main : Program Flags
main =
  Html.App.programWithFlags
    { init = init
    , view = view
    , update = update
    , subscriptions = subscriptions
    }


-- MODEL

type alias Model =
  { storyListModel: StoryList.Model
  , currentUser: User
  }

type alias User = { username : String }

type alias Flags =
  { currentUser : User }

initialModel : Model
initialModel =
  { storyListModel = StoryList.initialModel, currentUser = { username = "" } }

init : Flags -> (Model, Cmd Msg)
init flags =
  ( { storyListModel = StoryList.initialModel
    , currentUser = flags.currentUser
    }, Cmd.none )

decodeUser user =
  Json.Decode.decodeString user


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
    [
      div [ class "hello" ] [ text model.currentUser.username ]
    , Html.App.map StoryListMsg (StoryList.view model.storyListModel)
    ]
