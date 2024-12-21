import 'package:cloud_firestore/cloud_firestore.dart';


Future<void> initializeFirestore() async {
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  // ESB Canteen
  CollectionReference esbCanteen = firestore.collection('esb_canteen');
  await esbCanteen.add({
    'name': 'Idli Vada',
    'price': 45,
    'image': 'https://img-global.cpcdn.com/recipes/d9cf5bd1d52b26e1/680x482cq70/kushboo-idli-or-malligai-idli-and-vada-recipe-main-photo.jpg',
  });
  await esbCanteen.add({
    'name': 'Masala Dosa',
    'price': 45,
    'image': 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQJVrC2Z7OCjmZQ1vrNmWWaJRrMaJ9HzFn2kg&s',
  });

  // Multipurpose Canteen
  CollectionReference multipurposeCanteen = firestore.collection('multipurpose_canteen');
  await multipurposeCanteen.add({
    'name': 'Burger',
    'price': 50,
    'image': 'https://nishkitchen.com/wp-content/uploads/2020/10/Aloo-Tikki-Burger-1B.jpg',
  });
  await multipurposeCanteen.add({
    'name': 'Pizza',
    'price': 100,
    'image': 'https://dynamic-media-cdn.tripadvisor.com/media/photo-o/08/93/f2/83/caption.jpg?w=900&h=500&s=1',
  });

  // Law Canteen
  CollectionReference lawCanteen = firestore.collection('law_canteen');
  await lawCanteen.add({
    'name': 'Sandwich',
    'price': 30,
    'image': 'https://recipes.timesofindia.com/thumb/83740315.cms?width=1200&height=900',
  });
  await lawCanteen.add({
    'name': 'Pasta',
    'price': 60,
    'image': 'https://images.aws.nestle.recipes/resized/0a0717810b73a1672a029c29788e557b_creamy_alfredo_pasta_long_left_1080_850.jpg',
  });

  // Stationary
  CollectionReference stationary = firestore.collection('stationary');
  await stationary.add({
    'name': 'Notebook',
    'price': 20,
    'image': 'https://m.media-amazon.com/images/I/61m5H1fYccL._AC_UF1000,1000_QL80_.jpg',
  });
  await stationary.add({
    'name': 'Pen',
    'price': 10,
    'image': 'https://www.rapiddeliveryservices.in/uploads/ink_line_ball_pen_97233-.jpg',
  });

  // Xerox
  CollectionReference xerox = firestore.collection('xerox');
  await xerox.add({
    'name': 'B/W Photocopy',
    'price': 1
  });
  await xerox.add({
    'name': 'Color Printout',
    'price': 2
  });
}