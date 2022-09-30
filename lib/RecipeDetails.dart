import 'package:flutter/material.dart';

import 'models/Recipe.dart';

class RecipeDetails extends StatefulWidget {
  final Item recipe;
  final Color colour;

  RecipeDetails({required this.recipe, required this.colour});

  @override
  State<RecipeDetails> createState() => _RecipeDetailsState();
}

class _RecipeDetailsState extends State<RecipeDetails> {
  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    theme.copyWith(
      scaffoldBackgroundColor: Colors.white,
    );
    List<String> ingredients = [];
    for(int i = 0; widget.recipe.sections != null && i < widget.recipe.sections!.length; i++){
      for(int j = 0; widget.recipe.sections![i].components != null && j < widget.recipe.sections![i].components!.length; j++){
        if(widget.recipe.sections![i].components![j].rawText != null){
          ingredients.add(widget.recipe.sections![i].components![j].rawText!);
        }
      }
    }

    return Theme(
      data: theme.copyWith(
        scaffoldBackgroundColor: Colors.white,
        colorScheme: ColorScheme.fromSwatch().copyWith(
          primary: widget.colour,
        ),
      ),
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          elevation: 0.0,
          title: const Text(""),
          actions: [
            IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.notifications_outlined,
                  color: Colors.white,
                  size: 30,
                )
            )
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 300,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      color: widget.colour,
                      borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.circular(40),
                        bottomRight: Radius.circular(40),
                      )
                  ),
                  child: Stack(
                    clipBehavior: Clip.hardEdge, children: [
                      Positioned(
                        top: 0,
                        left: -5,
                        child: SizedBox(
                          width: MediaQuery.of(context).size.width * 0.6,
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(30, 20, 0, 20),
                            child: Column(
                              children: [
                                Text(widget.recipe.name!, style: const TextStyle(
                                    fontSize: 30.0, fontWeight: FontWeight.bold, color: Colors.white
                                )),
                                Padding(
                                  padding: const EdgeInsets.only(top: 20),
                                  child: Row(
                                    children: [
                                      const Padding(
                                        padding: EdgeInsets.only(right: 10),
                                        child: Icon(Icons.access_time, color: Colors.white, size: 30,),
                                      ),
                                      Text("${widget.recipe.cookTimeMinutes == null ? "?" : widget.recipe.cookTimeMinutes!} min", style: theme.textTheme.headline2,)
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 10),
                                  child: Row(
                                    children: [
                                      const Padding(
                                        padding: EdgeInsets.only(right: 10),
                                        child: Icon(Icons.person, color: Colors.white, size: 30,),
                                      ),
                                      Text("${widget.recipe.numServings == null ? 0 : widget.recipe.numServings!} servings", style: theme.textTheme.headline2,)
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 10),
                                  child: Row(
                                    children: [
                                      const Padding(
                                        padding: EdgeInsets.only(right: 10),
                                        child: Icon(Icons.local_fire_department_sharp, color: Colors.white, size: 30,),
                                      ),
                                      Text("${widget.recipe.nutrition == null ? 0 : widget.recipe.nutrition!.calories!} calories", style: theme.textTheme.headline2,)
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                          right: -70,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(200),
                            child: Image(
                              image: NetworkImage(widget.recipe.thumbnailUrl!),
                              height: 250.0,
                              width: 250.0,
                              fit: BoxFit.cover,
                            ),
                          ),
                      )
                    ],
                  )
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 30.0, horizontal: 20.0),
                child: Text("Nutrition per portion", style: theme.textTheme.headline5,),
              ),
              widget.recipe.nutrition != null ? Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Expanded(flex: 1, child: Text("")),
                  Expanded(
                    flex: 5,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("- carbs: ${widget.recipe.nutrition!.carbohydrates == null ? "?" : widget.recipe.nutrition!.carbohydrates!} g", style: theme.textTheme.bodyText2,),
                        Text("- sugar: ${widget.recipe.nutrition!.sugar == null ? "?" : widget.recipe.nutrition!.sugar!} g", style: theme.textTheme.bodyText2,),
                        Text("- fiber: ${widget.recipe.nutrition!.fiber == null ? "?" : widget.recipe.nutrition!.fiber!} g", style: theme.textTheme.bodyText2,)
                      ],
                    ),
                  ),
                  const Expanded(flex: 1, child: Text("")),
                  Expanded(
                    flex: 5,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("- protein: ${widget.recipe.nutrition!.protein == null ? "?" : widget.recipe.nutrition!.protein!} g", style: theme.textTheme.bodyText2,),
                        Text("- fat: ${widget.recipe.nutrition!.fat == null ? "?" : widget.recipe.nutrition!.fat!} g", style: theme.textTheme.bodyText2,),
                        Text("- calories: ${widget.recipe.nutrition!.calories == null ? "?" : widget.recipe.nutrition!.calories!} g", style: theme.textTheme.bodyText2,)
                      ],
                    ),
                  ),
                  const Expanded(flex: 1, child: Text("")),
                ],
              )
                  : const Text("No nutrition information!"),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 30.0, horizontal: 20.0),
                child: Text("Ingredients", style: theme.textTheme.headline5,),
              ),
              ingredients.isNotEmpty ?
              Row(
                children: [
                  const Spacer(),
                  Expanded(
                    flex: 5,
                    child: ListView.separated(
                        physics: const NeverScrollableScrollPhysics(),
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        itemBuilder: (BuildContext buildContext, int index){
                          return Text(ingredients[index], style: theme.textTheme.bodyText2,);
                        },
                        separatorBuilder: (BuildContext context, int index) => const Divider(),
                        itemCount: ingredients.length ~/ 2,
                    ),
                  ),
                  const Spacer(),
                  Expanded(
                    flex: 5,
                      child: ListView.separated(
                        physics: const NeverScrollableScrollPhysics(),
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        itemBuilder: (BuildContext buildContext, int index){
                          return Text(ingredients[index + ingredients.length ~/ 2], style: theme.textTheme.bodyText2,);
                        },
                        separatorBuilder: (BuildContext context, int index) => const Divider(),
                        itemCount: ingredients.length ~/ 2,
                      ),
                  ),
                  const Spacer(),
                ],
              ) :
              const Text("No ingredients information!"),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 30.0, horizontal: 20.0),
                child: Text("Directions", style: theme.textTheme.headline5,),
              ),
              widget.recipe.instructions != null ? ListView.separated(
                physics: const NeverScrollableScrollPhysics(),
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                itemBuilder: (BuildContext buildContext, int index){
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 35),
                    child: Text("${index+1}. ${widget.recipe.instructions![index].displayText!}", style: theme.textTheme.bodyText2, textAlign: TextAlign.justify,),
                  );
                },
                separatorBuilder: (BuildContext context, int index) => const Divider(),
                itemCount: widget.recipe.instructions!.length,
              ) :
              const Text("No instructions to show!"),
              const SizedBox(
                height: 100,
              )
            ],
          ),
        ),
        bottomNavigationBar: Theme(
          data: theme.copyWith(
            // sets the background color of the `BottomNavigationBar`
              canvasColor: Colors.white,
          ),
          child: BottomNavigationBar(
            showSelectedLabels: false,
            showUnselectedLabels: false,
            items: const [
              BottomNavigationBarItem(
                  icon: Icon(Icons.home_outlined, color: Colors.black,), label: "home"),
              BottomNavigationBarItem(
                  icon: Icon(Icons.bookmark_border_sharp, color: Colors.black,), label: "home"),
              BottomNavigationBarItem(icon: Icon(Icons.search, color: Colors.black,), label: "home"),
              BottomNavigationBarItem(
                  icon: Icon(Icons.person_outlined, color: Colors.black,), label: "home"),
            ],
          ),
        ),
      ),
    );
  }
}
