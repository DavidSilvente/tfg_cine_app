import 'package:cine_tfg_app/domain/entities/tv.dart';
import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';
import 'package:go_router/go_router.dart';


class TvHorizontalListview extends StatefulWidget {

  final List<Tv> tvs;
  final String? title;

  final VoidCallback? loadNextPage;

const TvHorizontalListview({
  super.key,
  required this.tvs,
  this.title,
  this.loadNextPage });

  @override
  State<TvHorizontalListview> createState() => _TvHorizontalListviewState();
}

class _TvHorizontalListviewState extends State<TvHorizontalListview> {

  final scrollController = ScrollController();

  @override
  void initState() {
    super.initState();

    scrollController.addListener(() {
      if(widget.loadNextPage == null) return;

      if ((scrollController.position.pixels + 200) >= scrollController.position.maxScrollExtent) {

        widget.loadNextPage!();
      }

    });
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context){
    return SizedBox(
      height: 280,
      child: Column(
        children: [

          if (widget.title != null)
            _Title(title: widget.title),
          
          Expanded(
            child: ListView.builder(
              controller: scrollController,
              itemBuilder: (context, index) {
                return FadeInRight(child: _Slide(tv: widget.tvs[index]));
              },
              itemCount: widget.tvs.length,
              scrollDirection: Axis.horizontal,
              physics: const BouncingScrollPhysics(),
            )
          )
        ],
      ),
    );
  }
}

class _Title extends StatelessWidget {

  

  final String? title;


  const _Title({
    this.title,
 });
    @override
    Widget build(BuildContext context){

        final textStyle = Theme.of(context).textTheme.titleLarge;

      return Container(

        margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
        child: Row(
          children: [
            if (title != null)
              Text(title!, style: textStyle,),
          ],
        ),

      );
    }
  }

class _Slide extends StatelessWidget {

  final Tv tv;

const _Slide({required this.tv });

  @override
  Widget build(BuildContext context){
        final textStyles = Theme.of(context).textTheme;
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 150,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: GestureDetector(
                onTap: () => context.push('/home/0/movie/${ tv.id }'),
                child: FadeInImage(
                  height: 220,
                  fit: BoxFit.cover,
                  placeholder: const AssetImage('assets/loaders/bottle-loader.gif'), 
                  image: NetworkImage(tv.posterPath)
                ),
              ),
            ),
          ),
          
        ],
      ),
    );
  }
}