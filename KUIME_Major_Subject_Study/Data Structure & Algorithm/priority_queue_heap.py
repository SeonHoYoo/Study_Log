import heapq

def minimize_fatigue(workloads, remaining_time):
  max_heap = [-work for work in workloads]
  heapq.heapify(max_heap)

  while remaining_time > 0 and max_heap:
    largest_work = -heapq.heappop(max_heap)

    if largest_work > 0:
      largest_work -= 1
      heapq.heappush(max_heap, -largest_work)

    remaining_time -= 1

  final_workloads = [-work for work in max_heap]
  fatigue = sum(work ** 2 for work in final_workloads)

  return final_workloads, fatigue

if __name__ == "__main__":
  print("enter work load >> ")
  workloads = list(map(int, input().strip().split()))

  print("enter remaining work times >> ")
  remaining_time = int(input().strip())

  fatigue = minimize_fatigue(workloads, remaining_time)
  print(fatigue[0], fatigue[1])