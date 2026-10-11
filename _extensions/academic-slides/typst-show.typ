#show: doc => presentation(
$if(title)$
  title: [$title$],
$endif$
$if(subtitle)$
  subtitle: [$subtitle$],
$endif$
  authors: (
$for(by-author)$
    [$it.name.literal$],
$endfor$
  ),
$if(date)$
  date: [$date$],
$endif$
$if(mainfont)$
  font: "$mainfont$",
$endif$
$if(codefont)$
  codefont: "$codefont$",
$endif$
$if(mathfont)$
  mathfont: "$mathfont$",
$endif$
$if(fontsize)$
  fontsize: $fontsize$,
$endif$
$if(slide-aspect)$
  aspect: "$slide-aspect$",
$endif$
$if(slide-numbers)$
  numbers: true,
$endif$
  doc,
)
