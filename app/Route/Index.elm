module Route.Index exposing (ActionData, Data, Model, Msg, route)

import BackendTask exposing (BackendTask)
import Color exposing (lightBrown)
import Effect
import Element exposing (..)
import Element.Background as Background
import Element.Border as Border
import Element.Events as Events
import Element.Font as Font
import FatalError exposing (FatalError)
import Head
import Head.Seo as Seo
import Html.Attributes exposing (style)
import Pages.Url
import PagesMsg exposing (PagesMsg)
import Route
import RouteBuilder exposing (App, StatefulRoute)
import Shared
import UrlPath
import View exposing (View)


type alias Model =
    { teamExpanded : Bool }


type Msg
    = ExpandTeam


type alias RouteParams =
    {}


type alias Data =
    {}


type alias ActionData =
    {}


route : StatefulRoute RouteParams Data ActionData Model Msg
route =
    RouteBuilder.single
        { head = head
        , data = data
        }
        |> RouteBuilder.buildWithLocalState
            { view = view
            , init = \_ _ -> ( { teamExpanded = False }, Effect.None )
            , update = \_ _ msg model -> ( update msg model, Effect.None )
            , subscriptions = \_ _ _ _ -> Sub.none
            }


update : Msg -> Model -> Model
update msg model =
    case msg of
        ExpandTeam ->
            { model | teamExpanded = True }


data : BackendTask FatalError Data
data =
    BackendTask.succeed Data


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
        , description = "Welcome to Horeca Productions!"
        , locale = Nothing
        , title = "Horeca Productions"
        }
        |> Seo.website


view :
    App Data ActionData RouteParams
    -> Shared.Model
    -> Model
    -> View (PagesMsg Msg)
view app shared model =
    { title = "Horeca Productions"
    , body =
        column [ width fill ]
            [ column [ width fill, Background.color (rgb255 53 30 30), spacing 88 ]
                [ el [] none
                , row [ centerX, width fill, spaceEvenly, paddingXY 135 0 ]
                    [ link [] { url = "#services", label = el headerFont (text "услуги") }
                    , link [] { url = "#history", label = el headerFont (text "история") }
                    , image [ height (px 83) ] { src = "/logo.svg", description = "logo" }
                    , link [] { url = "#team", label = el headerFont (text "команда") }
                    , link [] { url = "#blog", label = el headerFont (text "блог") }
                    ]
                , column
                    [ width fill
                    , htmlAttribute (style "overflow" "hidden")
                    , height (px 650)
                    , inFront (paragraph [ raleway, Font.color lightColor, moveDown 200, moveRight 135, width (px 370) ] [ text "Где подача — всё: дизайн, маркетинг, стратегия." ])
                    ]
                    [ el ([ alignRight, moveRight 40 ] ++ headerMainFont) (text "horeca")
                    , el ([ moveLeft 26 ] ++ headerMainFont) (text "productions")
                    ]
                ]
            , el [ Background.image "olives.png", width fill, paddingXY 135 35 ]
                (el
                    [ centerX
                    , Border.rounded 30
                    , Background.color (rgba 0 0 0 0.2)
                    , paddingXY 95 35
                    , htmlAttribute (style "backdrop-filter" "blur(40px)")
                    ]
                    (paragraph
                        [ Font.color (rgb255 210 197 178), raleway, Font.size 24 ]
                        [ text "Мы\u{00A0}— команда экспертов, которые знают ресторанный бизнес изнутри. Мы\u{00A0}не\u{00A0}просто оказываем услуги, мы\u{00A0}становимся вашими партнерами, погружаясь в\u{00A0}детали вашего бизнеса и\u{00A0}разрабатывая индивидуальные стратегии для достижения конкретных результатов." ]
                    )
                )
            , el [ Background.color (rgb255 210 197 178), width fill, htmlAttribute (Html.Attributes.id "services") ]
                (el [ width fill, Background.image "/text-bg.svg" ]
                    (column [ paddingXY 135 95, centerX, width fill ]
                        [ el [ ubuntu, Font.size 80, Font.color yellowColor, Font.color redColor ] (text "услуги для вашего бизнеса")
                        , el [ height (px 60) ] none
                        , row [ width fill, spaceEvenly, Font.color darkColor ]
                            [ column [ width (px 350), spacing 30 ]
                                [ el [ ubuntu, Font.size 320, Font.light ] (text "1.")
                                , el [ raleway, Font.size 24, Font.semiBold ] (paragraph [] [ text "полная разработка" ])
                                ]
                            , column [ width (px 350), spacing 30 ]
                                [ el [ ubuntu, Font.size 320, Font.light ] (text "2.")
                                , el [ raleway, Font.size 24, Font.semiBold ] (paragraph [] [ text "удаленная команда" ])
                                ]
                            , column [ width (px 350), spacing 30 ]
                                [ el [ ubuntu, Font.size 320, Font.light ] (text "3.")
                                , el [ raleway, Font.size 24, Font.semiBold ] (paragraph [] [ text "быстрый старт" ])
                                ]
                            ]
                        , el [ height (px 45) ] none
                        ]
                    )
                )
            , link [ width fill ]
                { url = "/horeca.pdf"
                , label =
                    el [ Background.color (rgb255 196 185 151), width fill, paddingXY 0 146 ]
                        (column [ width fill ]
                            [ image [ width (px 1129) ] { src = "/viliche.png", description = "Viliche" }
                            , el [ ubuntu, Font.size 32, Font.color redColor, alignRight, moveLeft 100, moveUp 130, Font.underline ] (text "о наших пакетах")
                            ]
                        )
                }
            , el
                [ Background.color (rgb255 210 197 178)
                , width fill
                , behindContent (image [ height (px 605), alignRight, moveDown 74 ] { src = "/oil.png", description = "oil" })
                , htmlAttribute (Html.Attributes.id "history")
                ]
                (paragraph
                    [ ubuntu
                    , Font.size 280
                    , paddingXY 135 95
                    , Font.color (rgb255 53 30 30)
                    ]
                    [ text "история бренда" ]
                )
            , el [ Background.color (rgb255 210 197 178), width fill, paddingXY 135 0, Font.size 24, Font.medium ] (paragraph [ raleway, Font.color darkColor ] [ text "Мы — Horeca Productions, команда, рожденная общей мечтой. Мы верили: рестораны могут покорять сердца не только кухней, но атмосферой, стилем, онлайн-присутствием. Энтузиасты, верящие в силу красивой идеи и продвижения, мы создаём вдохновляющие стратегии, завораживающий дизайн. Наша цель — сделать ваш ресторан звездой." ])
            , el [ height (px 96), Background.color (rgb255 210 197 178), width fill ] none
            , el [ width fill, Background.image "/bg.png", htmlAttribute (Html.Attributes.id "team") ]
                (el [ paddingXY 135 95, width fill ]
                    (column [ width fill, Background.color (rgb255 196 185 151), width fill, Border.rounded 30 ]
                        ([ el [ paddingXY 105 125 ] (image [ height (px 100) ] { src = "/team.png", description = "team" })
                         , row [ paddingEach { top = 0, left = 115, right = 115, bottom = 95 }, spaceEvenly, width fill ]
                            [ row [ spacing 30 ]
                                [ image [ height (px 240), width (px 160) ] { src = "/alim.jpg", description = "Alim" }
                                , column [ width (px 260), height (px 240) ]
                                    [ paragraph [ alignTop, Font.size 32 ] [ text "Алим Лаипанов" ]
                                    , paragraph [ alignBottom, Font.size 18 ] [ text "Копирайтер, администратор телеграм-канала. Создание текстов для рекламы, ведение и продвижение контента в Телеграм-канале." ]
                                    ]
                                ]
                            , row [ spacing 30 ]
                                [ image [ height (px 240), width (px 160) ] { src = "/ilia.jpg", description = "Alim" }
                                , column [ width (px 260), height (px 240) ]
                                    [ paragraph [ alignTop, Font.size 32 ] [ text "Илья Костюченко" ]
                                    , paragraph [ alignBottom, Font.size 18 ] [ text "Ведущий технический специалист. Разработка и поддержка технической инфраструктуры компании." ]
                                    ]
                                ]
                            ]
                         ]
                            ++ (case model.teamExpanded of
                                    False ->
                                        [ el
                                            [ Events.onClick <| PagesMsg.fromMsg ExpandTeam
                                            , pointer
                                            , Font.color redColor
                                            , ubuntu
                                            , paddingEach { top = 0, left = 115, right = 115, bottom = 95 }
                                            , Font.size 32
                                            , Font.underline
                                            ]
                                            (text "подробнее")
                                        ]

                                    True ->
                                        [ row [ paddingEach { top = 0, left = 115, right = 115, bottom = 95 }, spaceEvenly, width fill ]
                                            [ row [ spacing 30 ]
                                                [ image [ height (px 240), width (px 160) ] { src = "/yasha.jpg", description = "Alim" }
                                                , column [ width (px 260), height (px 240) ]
                                                    [ paragraph [ alignTop, Font.size 32 ] [ text "Яш Вардхан Сингх" ]
                                                    , paragraph [ alignBottom, Font.size 18 ] [ text "Гид гастротуризма. Проведение гастрономических туров, презентация культурных и гастрономических аспектов." ]
                                                    ]
                                                ]
                                            ]
                                        ]
                               )
                        )
                    )
                )
            , el [ htmlAttribute (Html.Attributes.id "blog"), width fill, Background.image "/bg2.png" ]
                (el [ paddingXY 135 95, width fill, Font.color (rgb255 205 197 178) ]
                    (column [ htmlAttribute (style "backdrop-filter" "blur(40px)"), paddingXY 125 0, Border.rounded 30, width fill ]
                        [ el [ height (px 135) ] none
                        , el [ Font.size 280, ubuntu ] (text "блог")
                        , el [ height (px 120) ] none
                        , el [ alignRight, ubuntu, Font.size 32, moveLeft 55 ]
                            (row []
                                [ link []
                                    { url = "https://dzen.ru/id/67f1ed371047046a46c0e665"
                                    , label = text "дзен"
                                    }
                                , text "/"
                                , link []
                                    { url = "https://t.me/horeca_productions"
                                    , label = text "telegram"
                                    }
                                , text "/"
                                , link []
                                    { url = "https://habr.com/ru/users/horeca_productions/"
                                    , label = text "хабр"
                                    }
                                ]
                            )
                        , el [ height (px 190) ] none
                        ]
                    )
                )
            , el [ Background.color darkColor, paddingXY 135 76, width fill ]
                (row [ spacing 90, spaceEvenly, width fill ]
                    [ image [ paddingEach { left = 0, right = 90, top = 0, bottom = 0 } ] { src = "/logo.svg", description = "logo" }
                    , row [ centerX, width fill, spacing 90, spacing 120 ]
                        [ link [] { url = "#services", label = el headerFont (text "услуги") }
                        , link [] { url = "#history", label = el headerFont (text "история") }
                        , link [] { url = "#team", label = el headerFont (text "команда") }
                        , link [] { url = "#blog", label = el headerFont (text "блог") }
                        ]
                    , row [ spacing 28 ]
                        [ -- link [] { url = "", label = image [] { src = "/tiktok.svg", description = "TikTok" } },
                          link [] { url = "https://www.instagram.com/horeca_productions_", label = image [] { src = "/inst.svg", description = "Instagram" } }
                        , link [] { url = "https://t.me/horeca_productions", label = image [] { src = "/tg.svg", description = "Telegram" } }
                        ]
                    ]
                )
            ]
    }


headerMainFont : List (Attribute msg)
headerMainFont =
    [ ubuntu, Font.size 280, Font.color lightColor ]


lightColor : Color
lightColor =
    rgb255 210 197 178


redColor : Color
redColor =
    rgb255 120 2 4


darkColor : Color
darkColor =
    rgb255 36 21 21


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
