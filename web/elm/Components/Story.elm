module Story exposing (view, Model)

import Html exposing (Html, span, strong, a, text, div, button)
import Html.Attributes exposing (class, href, method)

type alias Model =
  { creator : String,
    description : String,
    id : String,
    status : String,
    story_type : String
  }

view : Model -> Html a
view model =
  span [ class "story" ]
    [ div [] [ text ("Status: " ++ model.status) ]
    , div [] [ text ("Description: " ++ model.description ) ]
    , div [] [ text ("Created by: " ++ model.creator ) ]
    , div [] [ text ("Type: " ++ model.story_type ) ]
    , a [ href "#", class "delete" ] [ text "delete" ]
    ]
