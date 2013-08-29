ua = navigator.userAgent
doc = document

# use safe fonts on Chrome / Windows due to https://code.google.com/p/chromium/issues/detail?id=137692
if /Windows/.test(ua) && /Chrome\/2[0-9]/.test(ua) && /webkit/i.test(ua)
  node = doc.createElement 'style'
  node.type = 'text/css'
  node.appendChild doc.createTextNode "
    p, aside, li, input, small, span { font-family: Cambria, Arial, sans-serif !important }
    h1, h2, h3, h4, button, a.btn { font-family: Calibri, Arial, sans-serif !important }
    p, aside, li { font-size: 18px; }
    a.btn { font-weight: normal }
    pre.highlight, pre.highlight * { font-size: 14px; font-family: 'Lucida Console', monospace !important }
  "
  doc.getElementsByTagName('head')[0].appendChild node