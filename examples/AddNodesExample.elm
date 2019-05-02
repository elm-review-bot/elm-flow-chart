module AddNodesExample exposing (Model, Msg(..), init, main, update, view)

import Browser
import FlowChart
import Html exposing (..)
import Html.Attributes as A
import Html.Events
import FlowChart.Types as FCTypes


main : Program () Model Msg
main =
    Browser.element { init = init, view = view, update = update, subscriptions = subscriptions }


type alias Model =
    { canvasModel : FlowChart.Model
    , noOfNodes : Int
    }


type Msg
    = CanvasMsg FlowChart.Msg
    | AddNode


init : () -> ( Model, Cmd Msg )
init _ =
    ( { canvasModel =
            FlowChart.init
                { nodes =
                    [ createNode "0" (FCTypes.Position 100 200)
                    ]
                , position = FCTypes.Position 0 0
                }
                nodeToHtml
      , noOfNodes = 1
      }
    , Cmd.none
    )


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.map CanvasMsg (FlowChart.subscriptions model.canvasModel)


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        CanvasMsg cMsg ->
            let
                ( canvasModel, canvasCmd ) =
                    FlowChart.update cMsg model.canvasModel
            in
            ( { model | canvasModel = canvasModel }, Cmd.map CanvasMsg canvasCmd )

        AddNode ->
            let
                cCmd =
                    FlowChart.addNode
                        (createNode (String.fromInt model.noOfNodes) (FCTypes.Position 10 10))
            in
            ( { model | noOfNodes = model.noOfNodes + 1 }, Cmd.map CanvasMsg cCmd )


view : Model -> Html Msg
view mod =
    div []
        [ button [ Html.Events.onClick AddNode ] [ text "AddNode" ]
        , Html.map CanvasMsg
            (FlowChart.view mod.canvasModel
                [ A.style "height" "600px"
                , A.style "width" "85%"
                ]
            )
        ]


nodeToHtml : String -> Html FlowChart.Msg
nodeToHtml nodeType =
    div
        [ A.style "width" "40px"
        , A.style "height" "25px"
        , A.style "background-color" "white"
        , A.style "padding" "35px 45px"
        ]
        [ text nodeType ]



-- HELPER FUNCTIONS


createNode : String -> FCTypes.Position -> FCTypes.FCNode
createNode id position =
    { position = position
    , id = id
    , nodeType = "default"
    }