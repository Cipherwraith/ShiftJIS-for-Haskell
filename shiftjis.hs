module ShiftJIS where

import Data.Text.Lazy.Encoding
import Codec.Text.IConv as IConv
import qualified Data.Text.Lazy as T
import qualified Data.Text.Lazy.IO as T
import qualified Data.ByteString.Lazy as B
import Network.URI
import Network.HTTP.Conduit
import Control.Applicative

-- ShiftJIS is just a type synonym for lazy ByteString
type ShiftJIS = B.ByteString

-- UTF8 is a type synonym for lazy Text
type UTF8 = T.Text

-- URL is a type synonym for String 
type URL = String

-- Converts from UTF8 to ShiftJIS
utf8toShiftJIS :: UTF8 -> ShiftJIS
utf8toShiftJIS = convertFuzzy Discard "UTF-8" "SHIFT_JISx0213" . encodeUtf8

-- Converts ShiftJIS to UTF8
shiftJIStoUTF8 :: ShiftJIS -> UTF8
shiftJIStoUTF8 = decodeUtf8 . convertFuzzy Discard "SHIFT_JISX0213" "UTF-8"

-- Reads in a file that is in shift-jis format, and automatically converst it to UTF8
readFileShiftJISAsUTF8 :: FilePath -> IO UTF8
readFileShiftJISAsUTF8 filePath = shiftJIStoUTF8 <$> B.readFile filePath

-- Takes a file formatted as UTF8 and automatically converts it into shift-jis before writing
writeFileUTF8AsShiftJIS :: FilePath -> UTF8 -> IO ()
writeFileUTF8AsShiftJIS filePath content = B.writeFile filePath (utf8toShiftJIS content)

-- Downloads a website that is encoded in shift-jis and automatically converts it to UTF8
downloadFileShiftJISAsUTF8 :: URL -> IO ShiftJIS
downloadFileShiftJISAsUTF8 url = simpleHttp url
