# Elm FlowChart [Under Development]

FlowChart builder in elm.

## Install
```
elm install vernacular-ai/elm-flow-chart
```

## Examples
- [BasicExample](https://github.com/Vernacular-ai/elm-flow-chart/tree/master/examples/BasicExample.elm) [Minimal setup required to use the lib]
- [MultipleNodeTypesExample](https://github.com/Vernacular-ai/elm-flow-chart/tree/master/examples/MultipleNodeTypesExample.elm) [Configure different node types and link or port properties]
- [EventListenerExample](https://github.com/Vernacular-ai/elm-flow-chart/tree/master/examples/EventListenerExample.elm) [Subscribing to flowchart events]
- [AddNodesExample](https://github.com/Vernacular-ai/elm-flow-chart/tree/master/examples/AddNodesExample.elm) [Add or Remove Nodes]
- [SaveLoadFlowChartExample](https://github.com/Vernacular-ai/elm-flow-chart/tree/master/examples/SaveLoadFlowChartExample.elm) [Save or load Flowchart state as json]

## Usage
Its an easy to use library to build flow charts or state diagrams in elm. 

#### Basic
**1. Import this library**
```elm
import FlowChart
import FlowChart.Types as FCTypes
```

**2. Define Model**
```elm
type alias Model =
    { canvasModel : FlowChart.Model }
```

**3. Some Initialization**
```elm
type Msg
    = CanvasMsg FlowChart.Msg

subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.map CanvasMsg (FlowChart.subscriptions model.canvasModel)


init : () -> ( Model, Cmd Msg )
init _ =
    ( { canvasModel =
            FlowChart.init
                { nodes =
                    [ createNode "node-0" (FCTypes.Vector2 10 10)
                    , createNode "node-1" (FCTypes.Vector2 100 200)
                    ]
                , position = FCTypes.Vector2 0 0
                , links = []
                , portConfig = FlowChart.defaultPortConfig
                , linkConfig = FlowChart.defaultLinkConfig
                }
                nodeToHtml
      }
    , Cmd.none
    )

{-| Defines how a node should look. Map a string node type to html.
-}
nodeToHtml : String -> Html FlowChart.Msg
nodeToHtml nodeType =
    div
        [ A.style "width" "100%"
        , A.style "height" "100%"
        , A.style "background-color" "white"
        , A.style "box-sizing" "border-box"
        ]
        [ text nodeType ]
```
FlowChart `init` takes nodes, position, links and some configs for initial state. See [FCTypes](https://github.com/Vernacular-ai/elm-flow-chart/blob/master/src/FlowChart/Types.elm) to understand types used in the library.

**4. Update**
```elm
update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        CanvasMsg cMsg ->
            let
                ( canvasModel, canvasCmd ) =
                    FlowChart.update flowChartEvent cMsg model.canvasModel
            in
            ( { model | canvasModel = canvasModel }, canvasCmd )
```

**5. View**
```elm
view : Model -> Html Msg
view mod =
    div []
        [ FlowChart.view mod.canvasModel
            nodeToHtml
            [ A.style "height" "600px"
            , A.style "width" "85%"
            ]
        ]
```

See [examples](https://github.com/Vernacular-ai/elm-flow-chart/tree/master/examples) to better understand all the features and how to use them.

Visit [here](https://package.elm-lang.org/packages/vernacular-ai/elm-flow-chart/latest/) for docs and more information.