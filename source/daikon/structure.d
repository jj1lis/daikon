module daikon.structure;
import daikon.declare;

nothrow @system:

class CaboChaPacket{
    private:
        string _sentence;
        Tree* _tree;
    public:
        this(string _sentence){
            import std.string:toStringz;
            this._tree=createParser("").parse(_sentence.toStringz);
        }
        @property{
            string sentence(){return this._sentence;}
            Tree* tree(){return this._tree;}
        }
}
