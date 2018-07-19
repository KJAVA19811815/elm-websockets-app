module Main exposing (..)
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import WebSocket

main =
  Html.program
    { init = init
    , view = view
    , update = update
    , subscriptions = subscriptions
    }

type alias Model =
  { input : String
  , messages : List String
  }

init : (Model, Cmd Msg)
init =
    ( Model "" [], Cmd.none)

type Msg
  = Input String
  | Send
  | NewMessage String

update : Msg -> Model -> (Model, Cmd Msg)
update msg {input, messages} =
  case msg of
    Input newInput ->
      (Model newInput messages, Cmd.none)

    Send ->
      (Model "" messages, WebSocket.send "ws://localhost:3001/hello" input)

    NewMessage str ->
      (Model input (str :: messages), Cmd.none)

-- SUBSCRIPTIONS

subscriptions : Model -> Sub Msg
subscriptions model =
  WebSocket.listen "ws://localhost:3001/hello" NewMessage

view : Model -> Html Msg
view model =
  div []
    [ div [class ""] (List.map viewMessage model.messages)
    , input [onInput Input, required True] []
    , button [onClick Send, class "btn btn-primary"] [text "Send"]
    ]


viewMessage : String -> Html msg
viewMessage msg =
  div [] [ text msg ]
