﻿namespace StompParser

open FParsec
module StompParser =
    let Parse message =
        //PARSERS
        let pZero = pchar (char 0)
        let pNewLine = pchar (char 13)
        let pUntil = many1CharsTill (anyChar)
        //TOKENS
        let COLONSPACE = pchar ':' .>> spaces
        let LETTERS = many1Chars asciiLetter
        let IDENTIFIER =  many1Chars (choice [asciiLetter;pchar '-'])
        //SYNTAX
        let FirstLine = LETTERS .>> pNewLine
        let HeaderName = IDENTIFIER .>> spaces
        let HeaderValue = pUntil pNewLine
        let HeaderLine = HeaderName .>> COLONSPACE .>>. HeaderValue
        let Main = FirstLine .>>. many HeaderLine .>> pNewLine .>>. pUntil pZero
        //RUN
        match run Main message with
            | Success(((cmd,head),body), us, pos) -> Success(new StompMessages.StompMessage(cmd, head, body), us, pos)
            | Failure(a, b, c) -> Failure(a,b,c)