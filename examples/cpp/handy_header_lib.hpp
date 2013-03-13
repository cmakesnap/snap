#pragma once
// Simple header only CPP library example

#include <algorithm>

// Makes finding things in stl containers more concise.
template <typename C, typename K, typename V>
bool Find(const C& container, const K& key, V* value){
  typename C::const_iterator iter;
  iter = container.find(key);
  if (iter != container.end()){
    *value = iter->second;
    return true;
  }
  return false;
}

// Makes sorting stl containers more concise.
template <typename C>
void Sort(C* container){
  std::sort(container->begin(), container->end());
}

// Makes sorting stl containers more concise (allow comparator)
template <typename C, typename Comparator>
void Sort(C* container, Comparator comparator){
  std::sort(container->begin(), container->end(), comparator);
}

