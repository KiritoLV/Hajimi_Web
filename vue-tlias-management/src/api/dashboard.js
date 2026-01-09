import request from "@/utils/request";

/**
 * @description 获取仪表盘的统计数据
 * @returns {Promise<{code: number, data: {empCount: number, deptCount: number, clazzCount: number, stuCount: number}, msg: string}>}
 */
export const getDashboardStatsApi = () => {
  return request({
    url: "/dashboard/stats",
    method: "GET",
  });
};
