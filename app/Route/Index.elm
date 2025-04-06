module Route.Index exposing (ActionData, Data, Model, Msg, route)

import BackendTask exposing (BackendTask)
import Element exposing (..)
import Element.Background as Background
import Element.Font as Font
import FatalError exposing (FatalError)
import Head
import Head.Seo as Seo
import Html.Attributes exposing (style)
import Pages.Url
import PagesMsg exposing (PagesMsg)
import Route
import RouteBuilder exposing (App, StatelessRoute)
import Shared
import UrlPath
import View exposing (View)


type alias Model =
    {}


type alias Msg =
    ()


type alias RouteParams =
    {}


type alias Data =
    { message : String
    }


type alias ActionData =
    {}


route : StatelessRoute RouteParams Data ActionData
route =
    RouteBuilder.single
        { head = head
        , data = data
        }
        |> RouteBuilder.buildNoState { view = view }


data : BackendTask FatalError Data
data =
    BackendTask.succeed Data
        |> BackendTask.andMap
            (BackendTask.succeed "Hello!")


head :
    App Data ActionData RouteParams
    -> List Head.Tag
head app =
    Seo.summary
        { canonicalUrlOverride = Nothing
        , siteName = "Horeca Productions"
        , image =
            { url = [ "images", "icon-png.png" ] |> UrlPath.join |> Pages.Url.fromPath
            , alt = "elm-pages logo"
            , dimensions = Nothing
            , mimeType = Nothing
            }
        , description = "Welcome to Horeco Productions!"
        , locale = Nothing
        , title = "Horeca Productions"
        }
        |> Seo.website


view :
    App Data ActionData RouteParams
    -> Shared.Model
    -> View (PagesMsg Msg)
view app shared =
    { title = "elm-pages is running"
    , body =
        column [ width fill ]
            [ column [ width fill, Background.color (rgb255 53 30 30), spacing 88 ]
                [ el [] none
                , row [ width fill ]
                    [ el [ width (px 50) ] none
                    , row [ centerX, width fill, spaceEvenly ]
                        [ el headerFont (text "услуги")
                        , el headerFont (text "студия")
                        , image [ height (px 50) ] { src = "/logo.svg", description = "logo" }
                        , el headerFont (text "сотрудники")
                        , el headerFont (text "о нас")
                        ]
                    , el [ width (px 50) ] none
                    ]
                , column
                    [ width fill
                    , htmlAttribute (style "overflow" "hidden")
                    , height (px 650)
                    , inFront (paragraph [ raleway, Font.color lightColor, moveDown 200, moveRight 100, width (px 370) ] [ text "Где подача — всё: дизайн, маркетинг, стратегия." ])
                    ]
                    [ el ([ alignRight, moveRight 40 ] ++ headerMainFont) (text "horeca")
                    , el ([ moveLeft 26 ] ++ headerMainFont) (text "productions")
                    ]
                ]
            ]
    }


headerMainFont : List (Attribute msg)
headerMainFont =
    [ ubuntu, Font.size 280, Font.color lightColor ]


lightColor : Color
lightColor =
    rgb255 210 197 178


headerFont : List (Attribute msg)
headerFont =
    [ raleway, Font.size 24, Font.color (rgb255 170 147 32) ]


ubuntu : Attribute msg
ubuntu =
    Font.family [ Font.typeface "Ubuntu" ]


raleway : Attribute msg
raleway =
    Font.family [ Font.typeface "Raleway" ]
