// D-431: the double buffer (util/DoubleBuffer.h): front, back, publish, index.
#include "util/DoubleBuffer.h"

#include <cassert>
#include <cstdio>
#include <vector>

int main() {
	circuit::CDoubleBuffer<std::vector<int>> buffer;
	assert(buffer.IsFront(&buffer.At(0)) && !buffer.IsFront(&buffer.At(1)));
	assert(&buffer.Front() == &buffer.At(0) && &buffer.Back() == &buffer.At(1));
	assert(buffer.FrontPtr() == &buffer.At(0) && buffer.BackPtr() == &buffer.At(1));
	buffer.Back().push_back(7);          // the owner fills the back buffer
	assert(buffer.Front().empty());      // readers still see the old front
	buffer.Publish();
	assert(buffer.Front().size() == 1 && buffer.Front()[0] == 7 && buffer.Back().empty());
	assert(&buffer.Front() == &buffer.At(1) && buffer.IsFront(&buffer.At(1)));
	buffer.Publish();
	assert(&buffer.Front() == &buffer.At(0) && buffer.Back()[0] == 7);
	assert(&buffer.At(2) == &buffer.At(0) && &buffer.At(3) == &buffer.At(1));  // index wraps
	const auto& view = buffer;
	assert(&view.Front() == &buffer.At(0) && view.Back().size() == 1);
	std::puts("double buffer: front, back, publish and index PASS");
	return 0;
}
