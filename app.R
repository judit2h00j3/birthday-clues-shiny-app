options(repos = c(CRAN = "https://cran.rstudio.com/"))  

library(shiny)
library(rsconnect)

# Define pub crawl clues and correct answers
clues <- list(
  "First Stop: Before we paint the town pink, we start somewhere cozy but fierce. Think cocktails, chaos, and a mandatory photoshoot.",
  "Second Stop: Time to test your endurance. Strong cheap drinks, familiar faces, and a place where legends (and regrets) are made",
  "Third Stop: Time to belt out your guilty pleasure hits—no judgment.",
  "Fourth Stop: A Sip Before the Storm – A laid-back pit stop where the beer flows and the energy builds.",
  "Fifth Stop: All Glitter, No Limits – A club where the music slaps and the party never stops. Let’s end the night on the most fabulous note possible!"
)

answers <- c("Barbie House", "Klubben", "Skor", "Rabalder", "Gbar")  

# UI
ui <- fluidPage(
  titlePanel("Judit's 22nd Birthday Pub Crawl 🎉"),
  
  mainPanel(
    uiOutput("gameUI")  # Dynamic UI that switches between game and final invite
  )
)

# Server
server <- function(input, output, session) {
  index <- reactiveVal(1)  # Keeps track of progress
  hints <- c(
    "Before we take on the night, we start somewhere pink and bright. Drinks in hand, heels on the floor—where else have we partied before?", 
    "The drinks are cheap, the shots are strong—where students go to party long, and hopefully play a game of foosball.", 
    "Sing It Like You Mean It – A private stage, a mic in your hand, and no escape.", 
    "Before the final stop, let’s take a quick pitstop break. Beer in hand, at the familiar bar at the side of the river",
    "A place for queens, divas, and iconic vibes, where do we end this ride?"
  ) 
  
  game_complete <- reactiveVal(FALSE)  # Track if game is finished
  
  output$gameUI <- renderUI({
    if (game_complete()) {
      # FINAL INVITE SLIDE
      tagList(
        h2("🎉 YOU DID IT! See you tonight at my place! 🎉"),
        h3("Judit's 22nd Birthday Celebration"),
        p("Friday, March 14, 2025"),
        p("kl. 18.00 at Barbie House!"),
        p("I look forward to celebrate with all of you, xx"),
        img(src = "https://media.giphy.com/media/J93sVmfYBtsRi/giphy.gif", height = "300px")  # Fun GIF
      )
    } else {
      # GAME UI (before finishing)
      tagList(
        h3("Guess the next stop!"),
        textOutput("clue"),
        textInput("guess", "Enter your guess:"),
        actionButton("submit", "Submit"),
        actionButton("hint", "Need a hint?"),
        textOutput("hintText"),
        textOutput("feedback"),
        textOutput("progress"),
        img(src = "https://media.giphy.com/media/blSTtZehjAZ8I/giphy.gif", height = "300px") # Fun GIF
      )
    }
  })
  
  output$clue <- renderText({ clues[[index()]] })
  output$hintText <- renderText({ "" })
  output$progress <- renderText({ paste("Stop", index(), "of", length(clues)) })
  
  observeEvent(input$submit, {
    user_guess <- tolower(trimws(input$guess))
    correct_answer <- tolower(answers[index()])
    
    if (user_guess == correct_answer) {
      if (index() < length(clues)) {
        index(index() + 1)  # Move to the next clue
        updateTextInput(session, "guess", value = "")
        output$feedback <- renderText("✅ Correct! On to the next stop!")
      } else {
        game_complete(TRUE)  # Switch to final slide
      }
    } else {
      output$feedback <- renderText("❌ Wrong guess! Try again!")
    }
  })
  
  observeEvent(input$hint, {
    output$hintText <- renderText({ hints[index()] })
  })
}

shinyApp(ui = ui, server = server)

rsconnect::deployApp("C:/R shiny/")
shiny::runApp("C:/R shiny/")
runApp("C:/R shiny/")

rsconnect::setAccountInfo(name='judit2h00j3',
                          token='3195A72BD0F3E11B6CBC36DFB9ECE661',
                          secret='gWiH+zosHoUmt0NTm32wAFrz/+CCJ8N+GKO6rU1u')
update.packages(ask = FALSE, checkBuilt = TRUE)
install.packages("rsconnect", dependencies = TRUE)

