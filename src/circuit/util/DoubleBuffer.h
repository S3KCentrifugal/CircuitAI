#pragma once
// D-431: one explicit double buffer for the owner-builds, worker-reads
// pattern that the threat map, the influence map, the terrain areas and the
// path cost arrays each kept by hand ("data0, data1, an atomic pointer and
// the other one"). Front() is what readers see, Back() is what the next
// update fills, Publish() swaps them in one sequentially consistent store.
// At(i) addresses a buffer by index for initialisation that touches both.
// Semantics are those of the atomic pointer it replaces: a reader that loaded
// Front() keeps a valid object while the owner fills Back() and publishes;
// nothing is freed, the two objects live as long as the owner.
// Tests: tests/double_buffer_test.cpp.
#include <atomic>

namespace circuit {

template <class T>
class CDoubleBuffer {
public:
	CDoubleBuffer() : front(&buffers[0]) {}
	CDoubleBuffer(const CDoubleBuffer&) = delete;
	CDoubleBuffer& operator=(const CDoubleBuffer&) = delete;

	T& Front() { return *front.load(); }
	const T& Front() const { return *front.load(); }
	T* FrontPtr() const { return front.load(); }
	T& Back() { return *Other(front.load()); }
	const T& Back() const { return *Other(front.load()); }
	T* BackPtr() const { return Other(front.load()); }
	void Publish() { front.store(Other(front.load())); }
	T& At(int index) { return buffers[index & 1]; }
	const T& At(int index) const { return buffers[index & 1]; }
	bool IsFront(const T* p) const { return p == front.load(); }

private:
	T* Other(T* p) const { return p == &buffers[0] ? const_cast<T*>(&buffers[1]) : const_cast<T*>(&buffers[0]); }
	T buffers[2];
	std::atomic<T*> front;
};

} // namespace circuit
