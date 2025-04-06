module Route.Index exposing (ActionData, Data, Model, Msg, route)

import BackendTask exposing (BackendTask)
import Element exposing (..)
import Element.Background as Background
import Element.Border as Border
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
                        , image [ height (px 83) ] { src = "/logo.svg", description = "logo" }
                        , el headerFont (text "команда")
                        , el headerFont (text "блог")
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
            , el [ Background.image "olives.png", width fill, padding 20 ]
                (el
                    [ centerX
                    , Border.rounded 30
                    , Background.color (rgba 0 0 0 0.2)
                    , padding 20
                    , width (px 920)
                    , htmlAttribute (style "backdrop-filter" "blur(40px)")
                    ]
                    (paragraph
                        [ Font.color (rgb 1 1 1), raleway, Font.size 24 ]
                        [ text "Мы\u{00A0}— команда экспертов, которые знают ресторанный бизнес изнутри. Мы\u{00A0}не\u{00A0}просто оказываем услуги, мы\u{00A0}становимся вашими партнерами, погружаясь в\u{00A0}детали вашего бизнеса и\u{00A0}разрабатывая индивидуальные стратегии для достижения конкретных результатов." ]
                    )
                )
            , el [ Background.color (rgb255 210 197 178), width fill ]
                (el [ width fill, Background.image "/text-bg.svg" ]
                    (column [ paddingXY 135 95, centerX, width fill ]
                        [ el [ ubuntu, Font.size 80, Font.color yellowColor ] (text "услуги для вашего бизнеса")
                        , row [ width fill, spaceEvenly ]
                            [ column [ width (px 350) ]
                                [ el [ ubuntu, Font.color yellowColor, Font.size 320 ] (text "1.")
                                , el [ raleway, Font.color yellowColor, Font.size 24 ] (paragraph [] [ text "Для тех, кто готов к радикальному росту и хочет видеть свой ресторан на  вершине успеха." ])
                                ]
                            , column [ width (px 350) ]
                                [ el [ ubuntu, Font.color yellowColor, Font.size 320 ] (text "2.")
                                , el [ raleway, Font.color yellowColor, Font.size 24 ] (paragraph [] [ text "Для тех, кто хочет улучшить свои результаты и укрепить позиции на рынке." ])
                                ]
                            , column [ width (px 350) ]
                                [ el [ ubuntu, Font.color yellowColor, Font.size 320 ] (text "3.")
                                , el [ raleway, Font.color yellowColor, Font.size 24 ] (paragraph [] [ text "Для тех, кто хочет получить профессиональную оценку и рекомендации по  улучшению своего бизнеса." ])
                                ]
                            ]
                        ]
                    )
                )
            , el
                [ Background.color (rgb255 210 197 178)
                , width fill
                , behindContent (image [ height (px 605), alignRight, moveRight 46, moveDown 74 ] { src = "/oil.png", description = "oil" })
                ]
                (paragraph
                    [ ubuntu
                    , Font.size 240
                    , paddingXY 135 95
                    , Font.color darkColor
                    ]
                    [ text "история бренда" ]
                )
            , el [ Background.color (rgb255 210 197 178), width fill, paddingXY 135 95, Font.size 24 ] (paragraph [ raleway, Font.color darkColor ] [ text "Мы — Horeca Productions, команда, рожденная общей мечтой. Мы верили: рестораны могут покорять сердца не только кухней, но атмосферой, стилем, онлайн-присутствием. Энтузиасты, верящие в силу красивой идеи и продвижения, мы создаём вдохновляющие стратегии, завораживающий дизайн. Наша цель — сделать ваш ресторан звездой." ])
            , el [ width fill, Background.color (rgb255 210 197 178) ] (image [ centerX, height (px 613) ] { src = "/fork.png", description = "fork" })
            ]
    }


headerMainFont : List (Attribute msg)
headerMainFont =
    [ ubuntu, Font.size 280, Font.color lightColor ]


lightColor : Color
lightColor =
    rgb255 210 197 178


darkColor : Color
darkColor =
    rgb255 53 30 30


headerFont : List (Attribute msg)
headerFont =
    [ raleway, Font.size 24, Font.color yellowColor ]


yellowColor : Color
yellowColor =
    rgb255 170 147 32


ubuntu : Attribute msg
ubuntu =
    Font.family [ Font.typeface "Ubuntu" ]


raleway : Attribute msg
raleway =
    Font.family [ Font.typeface "Raleway" ]
