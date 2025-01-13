import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

class Buttons {
  defaultButtons({isLoading = false, title, action}) {
    return SizedBox(
      height: 53,
      width: double.infinity,
      child: ElevatedButton(
          onPressed: action,
          style: ElevatedButton.styleFrom(
              elevation: 0,
              backgroundColor: const Color(0xff009933),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50))),
          child: Center(
            child: isLoading
                ? const CircularProgressIndicator.adaptive(
                    backgroundColor: Colors.white,
                  )
                : AutoSizeText(
                    minFontSize: 8,
                    maxLines: 1,
                    title,
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontFamily: "PoppinsMeds"),
                  ),
          )),
    );
  }

  borderButtons(context, {title, action}) {
    return SizedBox(
      height: 53,
      width: double.infinity,
      child: ElevatedButton(
          onPressed: action,
          style: ElevatedButton.styleFrom(
              elevation: 0,
              backgroundColor: Theme.of(context).cardColor,
              side: const BorderSide(color: Color(0xff009933)),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50))),
          child: Center(
            child: AutoSizeText(
                minFontSize: 8,
              maxLines: 1,
              title,
              style: const TextStyle(
                  color: Color(0xff009933),
                  fontSize: 16,
                  fontFamily: "PoppinsMeds"),
            ),
          )),
    );
  }

  cancelButtons(context, {title, action}) {
    return SizedBox(
      height: 53,
      width: double.infinity,
      child: ElevatedButton(
          onPressed: action,
          style: ElevatedButton.styleFrom(
              elevation: 0,
              backgroundColor: Theme.of(context).highlightColor,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50))),
          child: Center(
            child: Text(
              title,
              style: const TextStyle(
                  color: Color(0xff828282),
                  fontSize: 16,
                  fontFamily: "PoppinsMeds"),
            ),
          )),
    );
  }

  dangerButtons({title, action, isLoading}) {
    return SizedBox(
      height: 53,
      width: double.infinity,
      child: ElevatedButton(
          onPressed: action,
          style: ElevatedButton.styleFrom(
              elevation: 0,
              backgroundColor: const Color(0xffDE4841),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50))),
          child: Center(
            child: isLoading
                ? const CircularProgressIndicator.adaptive(
                    backgroundColor: Colors.white,
                  )
                : Text(
                    title,
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontFamily: "PoppinsMeds"),
                  ),
          )),
    );
  }
}
