ShiftJIS-for-Haskell
====================

Convenient conversion functions for UTF8 and shiftJIS.

Example:

Basic imports
```haskell
import qualified Data.Text.Lazy as T
```

Download the contents of a website that is encoded in shiftjis:

```haskell
websiteContents <- downloadFileShiftJISAsUTF8 "http://www.2ch.net/"
```

Convert the website contents to UTF8:

```haskell
let websiteContentsUTF8 = shiftJIStoUTF8 websiteContents
```

Modify the contents of the website:

```haskell
let modifiedWebsiteContentsUTF8 = T.toUpper websiteContentsUTF8
```

Write the modified website to a file encoded with shiftjis:

```haskell
writeFileUTF8AsShiftJIS "indexNEW.html" modifiedWebsiteContentsUTF8
```

