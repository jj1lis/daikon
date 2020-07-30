module daikon.declare;

nothrow @system:

extern (C++){
    struct cabocha_chunk_t{
        int 	link;
        size_t 	head_pos;
        size_t 	func_pos;
        size_t 	token_size;
        size_t 	token_pos;
        float 	score;
        const char ** 	feature_list;
        const char * 	additional_info;
        ushort 	feature_list_size;
    }

    struct cabocha_token_t{
        const char * 	surface;
        const char * 	normalized_surface;
        const char * 	feature;
        const char ** 	feature_list;
        ushort 	feature_list_size;
        const char * 	ne;
        const char * 	additional_info;
        cabocha_chunk_t * 	chunk;
    }

    struct mecab_node_t;
}

extern(C++,CaboCha){
    //aliases

    alias Chunk = cabocha_chunk_t;
    alias Token = cabocha_token_t;

    //classes

    class Tree{
        void 	set_sentence (const char*);
        const char * 	sentence ();
        //size_t 	sentence_size ();
        void 	set_sentence (const char*, size_t);
        const Chunk * 	chunk (size_t);
        const Token * 	token (size_t);
        Chunk * 	mutable_chunk (size_t);
        Token * 	mutable_token (size_t);
        Token * 	add_token ();
        Chunk * 	add_chunk ();
        char * 	strdup (const char*);
        char * 	alloc (size_t);
        char ** 	alloc_char_array (size_t);
        //TreeAllocator * 	allocator ();
        bool 	read (const char*, InputLayerType);
        bool 	read (const char*, size_t, InputLayerType);
        bool 	read (const mecab_node_t*);
        //bool 	empty ();
        void 	clear ();
        void 	clear_chunk ();
        //size_t 	chunk_size ();
        //size_t 	token_size ();
        //size_t 	size ();
        //const char * 	toString (FormatType);
        const char * 	toString (FormatType, char*, size_t);
        //CharsetType 	charset ();
        //void 	set_charset (CharsetType);
        //PossetType 	posset ();
        //void 	set_posset (PossetType);
        //OutputLayerType 	output_layer ();
        //void 	set_output_layer (OutputLayerType);
        //const char * 	what ();
    }

    class Parser{
        const Tree * 	parse (const char*);
        const char * 	parseToString (const char *input)=0;
        const Tree * 	parse (Tree*);
        const Tree * 	parse (const char*, size_t);
        const char * 	parseToString (const char*, size_t);
        const char * 	parseToString (const char*, size_t, char*, size_t);
        const char * 	what ();
        //const Tree * 	parse (const char *input)=0;
        //const char * 	parseToString (const char *input)=0;
        //const Tree * 	parse (Tree *tree) =0;
        //const Tree * 	parse (const char *input, size_t length)=0;
        //const char * 	parseToString (const char *input, size_t length)=0;
        //const char * 	parseToString (const char *input, size_t length, char *output, size_t output_length)=0;
        //const char * 	what ()=0;
    }

    class TreeAllocator;

    //functions

    Parser* createParser(int, char**);
    Parser* createParser(const char*);

    const(char)* getParserError();
    const(char)* getLastError();
    bool runDependencyTraining(const char*, const char*, const char*, CharsetType, PossetType, double, int);
    bool runChunkingTraining(const char*, const char*, const char*, CharsetType, PossetType, double, int);

    //Enums

    enum  	CharsetType {
        EUC_JP,// = CABOCHA_EUC_JP,
        CP932,// = CABOCHA_CP932,
        UTF8,// = CABOCHA_UTF8,
        ASCII,// = CABOCHA_ASCII
    }

    enum  	PossetType {
        IPA,// = CABOCHA_IPA,
        JUMAN,// = CABOCHA_JUMAN,
        UNIDIC,// = CABOCHA_UNIDIC
    }

    enum  	FormatType {
        FORMAT_TREE,// = CABOCHA_FORMAT_TREE,
        FORMAT_LATTICE,// = CABOCHA_FORMAT_LATTICE,
        FORMAT_TREE_LATTICE,// = CABOCHA_FORMAT_TREE_LATTICE,
        FORMAT_XML,// = CABOCHA_FORMAT_XML,
        FORMAT_CONLL,// = CABOCHA_FORMAT_CONLL,
        FORMAT_NONE,// = CABOCHA_FORMAT_NONE
    }

    enum  	InputLayerType {
        INPUT_RAW_SENTENCE,// = CABOCHA_INPUT_RAW_SENTENCE,
        INPUT_POS,// = CABOCHA_INPUT_POS,
        INPUT_CHUNK,// = CABOCHA_INPUT_CHUNK,
        INPUT_SELECTION,// = CABOCHA_INPUT_SELECTION,
        INPUT_DEP,// = CABOCHA_INPUT_DEP
    }

    enum  	OutputLayerType {
        OUTPUT_RAW_SENTENCE,// = CABOCHA_OUTPUT_RAW_SENTENCE,
        OUTPUT_POS,// = CABOCHA_OUTPUT_POS,
        OUTPUT_CHUNK,// = CABOCHA_OUTPUT_CHUNK,
        OUTPUT_SELECTION,// = CABOCHA_OUTPUT_SELECTION,
        OUTPUT_DEP,// = CABOCHA_OUTPUT_DEP
    }

    enum  	ParserType { TRAIN_NE,// = CABOCHA_TRAIN_NE,
        TRAIN_CHUNK,// = CABOCHA_TRAIN_CHUNK,
        TRAIN_DEP,// = CABOCHA_TRAIN_DEP
    }
}
unittest{
    import std.string:toStringz;
    auto parser=createParser("");
    auto tree=parser.parse("今日は向坂くんが休みなので、明日までに机の上に花瓶を置いておきます。".toStringz);
    foreach(i;0..tree.size){
        //TODO
    }
}
