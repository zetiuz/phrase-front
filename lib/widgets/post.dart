import 'package:flutter/material.dart';
//import 'package:phrasis_frontend/comen_view.dart';
//import 'package:phrasis_frontend/profile_view.dart';

const phPrimary = Color(0xFF604777);
const phSecondary = Color(0xFFEBE8EE);
const phSecond = Color(0xC0503A69);

//final GlobalKey _contenido = GlobalKey();

class PostWidget extends StatefulWidget {

  final String username;
  final String content;
  final String backgroundImage;
  final bool isPost;
  final int likeNumber;
  final bool liked;
  final bool marked;
  final bool commented;


  const PostWidget({
    super.key,
    required this.username,
    required this.content,
    required this.isPost,
    this.backgroundImage = 'images/defaul.png',
    this.likeNumber = 0,
    this.liked = false,
    this.marked = false,
    this.commented = false,
  });

  @override
  State<PostWidget> createState() => _PostWidget();
}

class _PostWidget extends State<PostWidget> {
  
  bool liked = false;
  bool commented = false;
  bool marked = false;

  @override
  initialState() {
    super.initState();
    print('Iniciado');

    setState( () {
    liked = widget.liked;
    commented = widget.commented;
    marked = widget.marked;
    });
  }

  @override
  Widget build(BuildContext context) {

    return Container(
      clipBehavior: Clip.antiAlias,
      //color: Colors.red,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        //border: Border.all(color: Colors.green, width: 4),
        //color: phPrimary,
      ),
      //color: Colors.red,
      width: double.infinity,
      child: Column(
        children: [
          Container(
            width: double.infinity,
            //padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 13),
            //color: Colors.blue,
            child: TextButton(
              //padding: const EdgeInsets.all(0),
              onPressed: () {
                /*Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Profile(personalProfile: false)
                  ),
                );*/
              },
              child: SizedBox(
              width: double.infinity, child: Text(
              '@${widget.username}',
              textAlign: TextAlign.left, 
              //style: TextStyle(color: phSecondary),
              ),),
            ),
          ),
          Container(
                width: double.infinity,
                //key: _contenido,
                
                padding: const EdgeInsets.symmetric(vertical: 21, horizontal: 13),
                decoration: BoxDecoration(
                  //color: phSecondary,
    image: DecorationImage(
        //image: NetworkImage("https://img.freepik.com/free-photo/people-walking-down-street_1194-1142.jpg"),
        image: AssetImage(widget.backgroundImage == "assets/images/" ? 'assets/images/defaul.png' : widget.backgroundImage),
        fit: BoxFit.cover),
  ),
                child: Text(
                  widget.content,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    //color: phSecondary,
                    fontWeight: FontWeight.bold,
                    fontStyle: FontStyle.italic,
                    //backgroundColor: phSecond,
                  ),
                  ),
              ),
          Container(
            //color: Colors.brown,
            child: _actions()
          ),
        ],
      ),
    );
  }

  Widget _actions() {
    if (widget.isPost == true) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          IconButton(
            icon: Icon(
              liked ? Icons.favorite_rounded : Icons.favorite_border_rounded,
              //color: liked ? phSecondary : phSecondary,
            ),
            onPressed: () {
              print(liked);
              setState(
                () {
                  liked = !liked;
                }
              );
            },
          ),
          IconButton(
            icon: Icon(
              Icons.comment_rounded,
              //color: phSecondary,
              //color: commented ? Colors.black : Colors.blue,
            ),
            onPressed: () {
              /*Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Comment()
                  ),
                );*/
              },
          ),
          IconButton(
            icon: Icon(
              marked ? Icons.bookmark_rounded : Icons.bookmark_border_rounded,
              //color: marked ? phSecondary : phSecondary,
            ),
            onPressed: () {
              setState(
                () {
                  print(marked);
                  marked = !marked;
                }
              );
            },
          ),
        ],
      );
    }
    return Container();
  }
}
 