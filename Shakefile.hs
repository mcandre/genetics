import Development.Shake
import Development.Shake.FilePath
import System.Directory as Dir

main :: IO ()
main = do
  homeDir <- Dir.getHomeDirectory

  shakeArgs shakeOptions{ shakeFiles="dist" } $ do
    want ["install"]

    phony "install" $
      need ["dist/bin/hellogenetics" <.> exe]

    "dist/bin/hellogenetics" <.> exe %> \out ->
      cmd_ "cabal" "install" "--bindir" "dist/bin"

    phony "hlint" $
      cmd_ "hlint" "."

    phony "lint" $
      need ["hlint"]

    phony "test" $ do
      need ["dist/bin/hellogenetics" <.> exe]
      cmd_ ("dist/bin/hellogenetics" <.> exe)

    phony "uninstall" $
      removeFilesAfter homeDir ["/.cabal/bin/hellogenetics" <.> exe]

    phony "clean" $
      removeFilesAfter "dist" ["//*"]
