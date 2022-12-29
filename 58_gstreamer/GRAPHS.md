# README  

Demonstrate `gstreamer` graphs  

## Prereqs  

```sh
brew install graphviz
```

## Output

```sh
export GST_DEBUG_DUMP_DOT_DIR=./out/graphs
mkdir -p ${GST_DEBUG_DUMP_DOT_DIR}

# graph a mux
GST_DEBUG_DUMP_DOT_DIR=./out/graphs gst-launch-1.0 -m -v -e videotestsrc num-buffers=1000 ! x264enc ! mp4mux name=mux \
  ! filesink location="./out/testmux.mp4" audiotestsrc \
  ! lamemp3enc ! mux.

mkdir -p ./out/pdfs

while IFS=, read -r file1
do
    echo "file '$file1'"
    dot -Tpdf "./out/graphs/$file1" > "./out/pdfs/${file1}.pdf"
done < <(ls ./out/graphs)
```

## Resources

* GStreamer Graphs [here]https://embeddedartistry.com/blog/2018/02/22/generating-gstreamer-pipeline-graphs/)  
